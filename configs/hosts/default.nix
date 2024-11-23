{
  inputs,
  accountsLib,
  system,
  hostname,
  ...
}: let
  stateVersion = "24.05";
  isDarwin = false;
  wrapGL = false;
in {
  mkDefaultUserCfg = username: {
    inherit system hostname username;
    inherit stateVersion isDarwin wrapGL;
  };

  mkNixosUser = users: (
    builtins.listToAttrs (
      builtins.map (username: {
        name = username;
        value = import ./${hostname}/${username} {
          inherit inputs accountsLib system hostname username;
        };
      })
      users
    )
  );

  inherit stateVersion isDarwin;

  osPresets = {
    minimal = {
      enable = true;
    };
  };

  osFlavors = {};

  hmPresets = {
    minimal = {
      enable = true;
    };
  };

  hmFlavors = {};

  hmExtraConfig = {
    # My custom dotfiles
    direnvrc.enable = true;
    neovimrc.enable = true;
    tmuxrc.enable = true;
    zshrc.enable = true;
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

  editor = "nvim";
  terminal = "kitty";
  keyMap = "fr";

  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
  };

  console = {
    font = "Lat2-Terminus16";
    keyMap = "fr";
  };
}
