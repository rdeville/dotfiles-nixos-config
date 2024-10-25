{
  inputs,
  accountsLib,
  userCfg,
  ...
}: let
  mkLib = inputs.nixos.homeManagerModules.mkLib {inherit (inputs.nixos) inputs;};
  accounts = [];

  presets = {
    minimal.enable = true;
    common.enable = true;
    main.enable = true;
  };
in {
  inherit (userCfg) stateVersion username hostname;
  inherit presets;

  sudo = true;

  sops = {};
  home = "/root";

  accounts = import ../../../accounts/default.nix {
    userCfg =
      userCfg
      // {
        inherit presets;
      };
    inherit mkLib accountsLib accounts;
  };

  extraConfig = {
    # My custom dotfiles
    direnvrc.enable = true;
    neovimrc.enable = true;
    tmuxrc.enable = true;
    zshrc.enable = true;
    # My custom programs
    dotgit-sync.enable = true;
  };


  localPresets = {};
  # localPresets = {
  #   main.enable = true;
  # };

  localFlavors = {
    bin.enable = true;
  };

  flavors = {};

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
}
