{...}: {
  sops = {
    secrets = {
      "spotify-client-id" = {
        sopsFile = ../../../../common_secrets/spotify.enc.yaml;
      };
    };
  };

  wayland = {
    windowManager = {
      hyprland = {
        settings = {
          monitor = "eDP-1, 1620x1080@60, 0x0, 1";
        };
      };
    };
  };

  hm = {
    userAccounts = [
      "contact@romaindeville.fr"
      "contact@romaindeville.ovh"
    ];
  };
}
