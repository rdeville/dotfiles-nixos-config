{
  userCfg,
  pkgs,
  lib,
  ...
}: let
  moduleCfg =
    if userCfg.flavors ? discord
    then userCfg.flavors.discord
    else {
      enable = false;
    };
in {
  options = {
    discord = {
      enable = lib.mkEnableOption "Install discord Related Packages";
    };
  };

  config = lib.mkIf moduleCfg.enable {
    home = {
      packages = with pkgs; [
        discord
      ];
    };
  };
}
