{
  userCfg,
  lib,
  ...
}: let
  moduleCfg =
    if userCfg.localFlavors ? bin
    then userCfg.localFlavors.bin
    else {
      enable = false;
    };
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
