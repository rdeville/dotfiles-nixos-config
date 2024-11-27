{
  userCfg,
  pkgs,
  lib,
  ...
}: let
  moduleCfg =
    if userCfg.flavors ? latex
    then userCfg.flavors.latex
    else {
      enable = false;
    };
in {
  options = {
    latex = {
      enable = lib.mkEnableOption "Install latex Related Packages";
    };
  };

  config = lib.mkIf moduleCfg.enable {
    home = {
      packages = with pkgs; [
        texliveFull
      ];
    };
  };
}
