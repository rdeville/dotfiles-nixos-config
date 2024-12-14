{
  userCfg,
  lib,
  pkgs,
  ...
}: let
  moduleCfg =
    if userCfg.flavors ? terragrunt
    then userCfg.flavors.terragrunt
    else {
      enable = false;
    };
in {
  options = {
    terragrunt = {
      enable = lib.mkEnableOption "Install terragrunt Related Packages";
    };
  };

  config = lib.mkIf moduleCfg.enable {
    home = {
      packages = with pkgs; [
        terragrunt
      ];
    };
  };
}
