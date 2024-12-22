{
  config,
  lib,
  ...
}: let
  name = "printing";
  cfg = config.os.flavors.${name};
in {
  options = {
    os = {
      flavors = {
        ${name} = {
          enable = lib.mkEnableOption "Install Bluetooth Related Packages";
        };
      };
    };
  };

  config = lib.mkIf cfg.enable {
    users = {
      users =
        builtins.mapAttrs (name: userCfg: {
          extraGroups = [
            "lp"
            "scanner"
          ];
        })
        config.os.users;
    };

    services = {
      # CUPS
      printing = {
        enable = true;
      };
    };
  };
}
