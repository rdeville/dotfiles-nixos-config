{
  inputs,
  accountsLib,
  userCfg,
  ...
}: let
  mkLib = inputs.nixos.homeManagerModules.mkLib {inherit (inputs.nixos) inputs;};
  accounts = [
    "contact@romaindeville.fr"
    "contact@romaindeville.ovh"
  ];

  presets = {
    minimal.enable = true;
    common.enable = true;
    main.enable = true;
    gui.enable = true;
  };
in {
  inherit (userCfg) stateVersion username hostname;
  inherit presets;

  sudo = true;

  sops = {
    age = {
      keyFile = "/home/rdeville/.cache/.age.key";
    };
    defaultSopsFile = ./rdeville.enc.yaml;
    secrets =
      builtins.listToAttrs (
        builtins.map (address: {
          name = "accounts/${address}";
          value = {
            sopsFile = ../../../accounts/${address}/credentials.enc.yaml;
          };
        })
        accounts
      )
      // {
        "spotify-client-id" = {};
      };
  };

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
    awesomerc.enable = true;
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

  flavors = {
    gh.enable = true;
    glab.enable = true;
  };

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
