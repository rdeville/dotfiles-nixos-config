{
  config,
  lib,
  ...
}: let
  name = builtins.baseNameOf ./.;
  cfg = config.os.flavors.${name};
in {
  options = {
    os = {
      flavors = {
        ${name} = {
          enable = lib.mkEnableOption "Install ${name} NixOS flavors.";
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
        config.os.users.users;
    };

    services = {
      # CUPS
      printing = {
        enable = true;
      };
    };
  };
}
