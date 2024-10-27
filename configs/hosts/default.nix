{
  stateVersion = "24.05";

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
}
