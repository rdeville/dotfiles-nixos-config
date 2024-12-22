{
  config,
  pkgs,
  lib,
  ...
}: let
  name = "nextcloud-client";
  cfg = config.hm.flavors.${name};
in {
  options = {
    hm = {
      flavors = {
        ${name} = {
          enable = lib.mkEnableOption "Install ${name} Home-Manager flavor.";
        };
      };
    };
  };

  config = lib.mkIf cfg.enable {
    home = {
      packages = with pkgs; [
        nextcloud-client
      ];
    };

    services = {
      nextcloud-client = {
        enable = true;
        startInBackground = true;
      };
    };
  };
}
