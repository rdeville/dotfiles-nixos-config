{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.os;

  defaultGroup = [
    "networkmanager"
  ];
  guiGroup = [
    "video"
    "audio"
    "camera"
  ];
  sudoGroup = [
    "wheel"
  ];
in {
  options = {
    os = {
      users = lib.mkOption {
        description = "Configure NixOS users.";
        default = {};
        type = lib.types.attrsOf (
          lib.types.submodule (
            {name, ...}: {
              options = {
                isSudo = lib.mkOption {
                  type = lib.types.bool;
                  description = "Set to true if the user can be sudo.";
                  default = false;
                };
              };
            }
          )
        );
      };
    };
  };

  config = {
    users = {
      defaultUserShell = pkgs.zsh;
      mutableUsers = true;
      users =
        builtins.mapAttrs (name: userCfg: {
          shell = pkgs.zsh;
          isNormalUser = name != "root";
          extraGroups =
            defaultGroup
            ++ (
              if cfg.isGui
              then guiGroup
              else []
            )
            ++ (
              if userCfg.isSudo
              then sudoGroup
              else []
            );
        })
        cfg.users;
    };
  };
}
