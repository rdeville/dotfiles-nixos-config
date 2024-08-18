{
  mkLib,
  inputs,
  ...
}: let
  defaults = {
    system = "x86_64-linux";
    stateVersion = "24.05";
    editor = "nvim";
    terminal = "kitty";
    presets = {
      gui = false;
      main = false;
      game = false;
      server = false;
      work = false;
      container = false;
    };
    # location = "$HOME/.cache/nix/.setup";
    modules = [];
  };

  modules = [
    # Personnal home-manager packaged dotfiles
    inputs.awesomerc.homeManagerModules.awesomerc
    inputs.direnvrc.homeManagerModules.direnvrc
    inputs.neovimrc.homeManagerModules.neovimrc
    inputs.tmuxrc.homeManagerModules.tmuxrc
    inputs.zshrc.homeManagerModules.shellrc
    # Personnal packaged programs
    inputs.dotgit-sync.homeManagerModules.dotgit-sync
    ../modules/home-manager.nix
    ../home-manager/default.nix
  ];

  git = {
    perso = {
      condition = "gitdir:/";
      contents = {
        commit = {
          gpgSign = true;
        };
        credential = {
          "https://framagit.org" = {
            username = "rdeville";
          };
          "https://github.com" = {
            username = "rdeville";
          };
          "https://gitlab.com" = {
            username = "rdeville";
          };
        };
        push = {
          gpgSign = "if-asked";
        };
        tag = {
          forceSignAnnotated = true;
          gpgSign = true;
        };
        user = {
          name = "Romain Deville";
          email = "code@romaindeville.fr";
          signingKey = "0x700E80E57C25C99A";
        };
      };
    };
  };

  mergeUserWithDefaults = hostname: userCfgs:
  # Must do accounts after merge of presets is done
    builtins.mapAttrs (
      username: userCfg:
        userCfg
        // {
          accounts = import ./accounts {inherit mkLib userCfg;};
        }
    )
    (builtins.mapAttrs (username: userCfg:
      defaults
      // userCfg
      // {
        hostname = hostname;
        username = username;
        presets =
          defaults.presets
          // (
            if (userCfg ? presets)
            then userCfg.presets
            else
              {}
              // userCfg
          );
        accounts =
          if userCfg ? accounts
          then userCfg.accounts
          else [];
        modules =
          if userCfg ? modules
          then modules ++ userCfg.modules
          else modules;
        git =
          if userCfg ? git
          then git // userCfg.git
          else git;
        config =
          if userCfg ? extraConfig
          then userCfg.extraConfig
          else {};
      })
    userCfgs);

  mergeHostWithDefaults = hostCfgs:
    builtins.mapAttrs (
      hostname: hostCfg:
        defaults
        // hostCfg
        // {
          hostname = hostname;
          users = mergeUserWithDefaults hostname hostCfg.users;
          presets = defaults.presets // hostCfg.presets;
        }
    )
    hostCfgs;
in {
  hosts = mergeHostWithDefaults (import ./hosts {inherit inputs;});
  vms = mergeHostWithDefaults (import ./vms {inherit inputs;});
}
