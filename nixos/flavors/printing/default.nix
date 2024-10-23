{
  config,
  inputs,
  hostCfg,
  lib,
  pkgs,
  ...
}: let
  mkLib = import ../../../lib/default.nix {inherit inputs;};
  flavorCfg =
    if hostCfg.flavors ? printing
    then hostCfg.flavors.printing
    else {
      enable = false;
    };
in {
  imports =
    builtins.map (
      item: (import ./${item} {inherit inputs hostCfg flavorCfg config lib pkgs;})
    ) (builtins.filter (
      item:
        item != "default.nix"
    ) (mkLib.mkListFiles ./.));

  options = {
    printing = {
      enable = lib.mkEnableOption "Install Bluetooth Related Packages";
    };
  };

  config = lib.mkIf flavorCfg.enable {
    users = {
      users = builtins.listToAttrs (
        builtins.map (username: {
          name = "${username}";
          value = {
            isNormalUser = true;
            extraGroups = [
              "lp"
              "scanner"
            ];
          };
        }) (builtins.attrNames hostCfg.users)
      );
    };

    services = {
      # CUPS
      printing = {
        enable = true;
      };
    };
  };
}
