{
  userCfg,
pkgs,
  lib,
  ...
}: let
  moduleCfg = userCfg.flavors.bin;
in {
  options = {
    bin = {
      enable = lib.mkEnableOption "Install my custom script bin";
    };
  };

  config = lib.mkIf moduleCfg.enable {
    xdg = {
      dataFile = {
        "bin" = {
          enable = true;
          recursive = true;
          source = ./scripts;
        };
      };
    };
  };
}
