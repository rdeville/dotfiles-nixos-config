{
  userCfg,
  config,
  pkgs,
  lib,
  ...
}: let
  moduleCfg =
    if userCfg.flavors ? bluetooth
    then userCfg.flavors.bluetooth
    else {
      enable = false;
    };
in {
  options = {
    bluetooth = {
      enable = lib.mkEnableOption "Install Bluetooth Related Packages";
    };
  };

  config = lib.mkIf moduleCfg.enable {
    home = {
      packages = with pkgs; [
        bluetuith
      ];
    };

    xdg = {
      configFile = {
        "bluetuith/bluetuith.conf" = {
          enable = with pkgs; builtins.elem bluetuith config.home.packages;
          text = ''
            {
              keybindings: {
                Menu : Shift+m
                Quit: q
              }
            }
            # vim: ft=hjson
          '';
        };
      };
    };
  };
}
