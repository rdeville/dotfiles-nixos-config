{...}: {
  sops = {
    secrets = {
      "spotify-client-id" = {
        sopsFile = ../../../../common/secrets/spotify.enc.yaml;
      };
    };
  };

  wayland = {
    windowManager = {
      hyprland = {
        extraConfig = ''
          monitor = eDP-1,1620x1080@60.0,1110x1080,1.0
          # Dock monitor
          monitor = DP-7,1920x1080@60.0,0x0,1.0
          monitor = DP-8,1920x1080@60.0,1920x0,1.0
        '';
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
