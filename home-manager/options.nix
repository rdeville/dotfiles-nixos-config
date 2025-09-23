{
  osConfig ? {},
  lib,
  ...
}: {
  options = {
    hm = {
      isMain = lib.mkOption {
        type = lib.types.bool;
        description = "Define HM is for a main computer.";
        default =
          if osConfig ? os.isMain
          then osConfig.os.isMain
          else false;
      };

      isGui = lib.mkOption {
        type = lib.types.bool;
        description = "Define HM is for a gui computer.";
        default =
          if osConfig ? os.isGui
          then osConfig.os.isGui
          else false;
      };

      isProd = lib.mkOption {
        type = lib.types.bool;
        description = "Define HM is for a prod computer.";
        default =
          if osConfig ? os.isGui
          then osConfig.os.isGui
          else false;
      };

      userAccounts = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        description = "List of user accounts in config/accounts folder.";
        default = [];
        example = [
          "contact@domain.tld"
        ];
      };
    };
  };
}
