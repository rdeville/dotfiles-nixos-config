{
  userCfg,
  config,
  pkgs,
  lib,
  ...
}: let
  cfg =
    if userCfg.flavors ? nextcloud-client
    then config.nextcloud-client // userCfg.flavors.nextcloud-client
    else {
      enable = false;
    };
in {
  options = {
    nextcloud-client = {
      enable = lib.mkEnableOption "Install nextcloud-client Related Packages";
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
