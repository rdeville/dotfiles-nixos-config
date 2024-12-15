{
  userCfg,
  pkgs,
  lib,
  ...
}: let
  moduleCfg =
    if userCfg.flavors ? whatsapp
    then userCfg.flavors.whatsapp
    else {
      enable = false;
    };

  linuxPkgs = with pkgs; [
    whatsapp-for-linux
  ];
  darwinPkgs = [];
in {
  options = {
    whatsapp = {
      enable = lib.mkEnableOption "Install whatsapp (GitLab CLI) Related Packages";
    };
  };

  config = lib.mkIf moduleCfg.enable {
    home = {
      packages = (
        if userCfg.isDarwin
        then darwinPkgs
        else linuxPkgs
      );
    };
  };
}
