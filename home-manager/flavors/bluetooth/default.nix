{
  config,
  lib,
  pkgs,
  ...
}: let
  name = builtins.baseNameOf ./.;
  cfg = config.hm.flavors.${name};
in {
  options = {
    hm = {
      flavors = {
        ${name} = {
          enable = lib.mkEnableOption "Install Bluetooth Related Packages";
        };
      };
    };
  };

  config = lib.mkIf cfg.enable {
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
