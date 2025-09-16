{config, ...}: let
  keyFile = "${config.xdg.cacheHome}/.age.key";
in {
  sops = {
    age = {
      inherit keyFile;
    };
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
          monitor = HDMI-A-1,2560x1440@59.95,0x0,1.66667
        '';
      };
    };
  };

  hm = {
    flavors = {
      bluetooth = {
        enable = true;
      };
    };
  };
}
