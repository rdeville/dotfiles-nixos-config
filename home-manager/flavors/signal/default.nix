{
  userCfg,
  pkgs,
  lib,
  ...
}: let
  moduleCfg =
    if userCfg.flavors ? signal
    then userCfg.flavors.signal
    else {
      enable = false;
    };
in {
  options = {
    signal = {
      enable = lib.mkEnableOption "Install Signal Desktop Related Packages";
    };
  };

  config = lib.mkIf moduleCfg.enable {
    home = {
      packages = with pkgs; [
        signal-desktop
      ];
    };
  };
}
