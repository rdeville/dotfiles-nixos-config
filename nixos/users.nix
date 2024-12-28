{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.os.users;

  defaultGroup = [
    "networkmanager"
  ];
  sudoGroup = user:
    if user.isSudo
    then [
      "wheel"
    ]
    else [];
in {
  options = {
    os = {
      users = {
        defaultUserShell = lib.mkOption {
          type = lib.types.package;
          description = "The default shell all users.";
          default = pkgs.zsh;
        };
        users = lib.mkOption {
          description = "Configure NixOS users.";
          default = {};
          type = lib.types.attrsOf (
            lib.types.submodule {
              options = {
                isSudo = lib.mkOption {
                  type = lib.types.bool;
                  description = "Set to true if the user can be sudo.";
                  default = false;
                };
                shell = lib.mkOption {
                  type = lib.types.str;
                  description = "The shell for the user.";
                  default = "zsh";
                };
              };
            }
          );
        };
      };
    };
  };

  config = {
    users = {
      inherit (cfg) defaultUserShell;
      mutableUsers = true;
      users =
        builtins.mapAttrs (
          name: user: {
            shell = pkgs.${user.shell};
            isNormalUser = name != "root";
            extraGroups =
              defaultGroup
              ++ (sudoGroup user);
          }
        )
        cfg.users;
    };

    programs = builtins.listToAttrs (
      builtins.map (
        name: let
          shell = cfg.users.${name}.shell;
        in {
          name = shell;
          value = {
            enable = true;
          };
        }
      ) (builtins.attrNames cfg.users)
    );
  };
}
