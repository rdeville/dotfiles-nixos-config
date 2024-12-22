{
  config,
  pkgs,
  lib,
  ...
}: let
  name = "whatsapp";

  cfg = config.hm.flavors.${name};

  linuxPkgs = with pkgs; [
    whatsapp-for-linux
  ];
  darwinPkgs = [];
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
      packages = (
        if config.hm.isDarwin
        then darwinPkgs
        else linuxPkgs
      );
    };
  };
}
