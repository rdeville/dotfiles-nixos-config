{
  # Uncomment if needed to import other files or folder
  # mkLib,
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
  # Uncomment if needed to import other files or folder
  # imports = builtins.map (item: ./${item}) ((builtins.filter (
  #     item:
  #       item != "default.nix"
  #   ) (mkLib.mkListFiles ./.))
  #   ++ (mkLib.mkListDirs ./.));
in {
  # Uncomment if needed to import other files or folder
  # imports = lib.mkIf moduleCfg.enable imports;

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
