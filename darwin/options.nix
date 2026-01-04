{lib, ...}: {
  options = {
    os = {
      # BASE CONFIGURATION
      hostName = lib.mkOption {
        type = lib.types.str;
        description = "Hostname where config will be applied.";
      };

      parentName = lib.mkOption {
        type = lib.types.str;
        description = "If OS is a container or a VM, this store the name of the host OS";
        default = "";
      };

      stateVersion = lib.mkOption {
        type = lib.types.str;
        description = "Version of HM to follow";
        default = 6;
      };

      system = lib.mkOption {
        type = lib.types.str;
        description = "Arch system where config will be applied.";
        default = "x86_64-linux";
      };

      timeZone = lib.mkOption {
        type = lib.types.str;
        description = "The timezone of the host.";
        default = "Europe/Paris";
      };

      # BOOLEAN TO PARAMETERIZE SOME FLAVORS
      isMain = lib.mkEnableOption "Main computer.";
      isGui = lib.mkEnableOption "GUI computer.";
      isWork = lib.mkEnableOption "Work computer.";
    };
  };
}
