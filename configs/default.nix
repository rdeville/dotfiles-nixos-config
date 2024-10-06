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

  extraConfig = {
    # My custom dotfiles
    awesomerc.enable = true;
    direnvrc.enable = true;
    neovimrc.enable = true;
    tmuxrc.enable = true;
    zshrc.enable = true;
    # My custom programs
    dotgit-sync.enable = true;
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
          if (userCfg ? presets)
          then
            defaults.presets
            // userCfg.presets
          else defaults.presets;
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
          then extraConfig // userCfg.extraConfig
          else extraConfig;
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

  mkListDirs = inode:
    builtins.map (elem: elem.name) (
      builtins.filter (inode: inode.value == "directory") (
        builtins.map (key: {
          name = key;
          value = builtins.getAttr key (builtins.readDir inode);
        })
        (builtins.attrNames (builtins.readDir inode))
      )
    );

  mkAccountsSecrets = accounts:
    builtins.listToAttrs (
      builtins.map (item: {
        name = "accounts/${builtins.replaceStrings ["_at_"] ["@"] item}";
        value = {
          sopsFile = ./accounts/${item}/credentials.enc.yaml;
        };
      })
      accounts
    );

  lib = {
    mkListDirs = mkListDirs;
    mkAccountsSecrets = mkAccountsSecrets;
  };
in {
  hosts = mergeHostWithDefaults (import ./hosts {inherit inputs lib;});
  vms = mergeHostWithDefaults (import ./vms {inherit inputs;});
}
