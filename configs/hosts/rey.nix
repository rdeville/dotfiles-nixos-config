{accounts, ...}: let
  sudo = true;
  main = true;
  gui = true;
in {
  "rey" = {
    presets = {
      inherit
        gui
        main
        ;
    };
    users = {
      "rdeville" = {
        home-manager = {
          xresources = {
            properties = {
              "Xft.dpi" = "97x96";
            };
          };
        };
        sops = {
          enable = true;
          defaultSopsFile = ../secrets/rey/rdeville.enc.yaml;
        };
        accounts = accounts;
        presets = {
          inherit
            sudo
            gui
            main
            ;
        };
        flavors = {
          bluetooth = {
            enable = true;
          };
          spotify-player = {
            enable = true;
          };
        };
      };
    };
  };
}
