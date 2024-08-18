{...}: let
  sudo = true;
  main = true;
  gui = true;
in {

  rey = {
    presets = {
      inherit
        gui
        main
        ;
    };
    users = {
      rdeville = {
        home-manager = {
          xresources = {
            properties = {
              "Xft.dpi" = "97x96";
            };
          };
        };
        sops = {
          enable = true;
          keyFile = "/home/rdeville/.cache/.age.key";
          defaultSopsFile = ../secrets/rey/rdeville.enc.yaml;
        };
        accounts = [
          "contact@romaindeville.fr"
          "contact@romaindeville.ovh"
        ];
        git = {
          # pro = {
          #   condition = "gitdir:~/**pro**";
          #   contents = {
          #     commit = {
          #       gpgSign = true;
          #     };
          #     push = {
          #       gpgSign = "if-asked";
          #     };
          #     tag = {
          #       forceSignAnnotated = true;
          #       gpgSign = true;
          #     };
          #     user = {
          #       name = "Romain Deville";
          #       email = "TODO: Update email";
          #       signingKey = "TODO: Update signKey";
          #     };
          #   };
          # };
        };
        presets = {
          inherit
            sudo
            gui
            main
            ;
        };
        flavors = {
          bin = {
            enable = true;
          };
          bluetooth = {
            enable = true;
          };
          spotify-player = {
            enable = true;
            client_id = "5ac4a3019524480dbd73b7bf729cc832";
            audio_backend = "pulseaudio";
          };
          vscode = {
            enable = true;
          };
          gh = {
            enable = true;
          };
          glab = {
            enable = true;
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
      };
    };
  };
}
