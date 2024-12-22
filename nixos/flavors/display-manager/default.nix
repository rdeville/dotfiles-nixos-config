{
  config,
  lib,
  ...
}: let
  name = "display-manager";
  cfg = config.os.flavors.${name};
in {
  imports = builtins.map (item: ./${item}) (lib.importDir ./.);

  options = {
    os = {
      flavors = {
        ${name} = {
          enable = lib.mkEnableOption "Install ${name} NixOS flavors.";
          gdm = {
            enable = lib.mkEnableOption "Install gdm as display manager.";
          };
          ly = {
            enable = lib.mkEnableOption "Install ly as display manager.";
          };
        };
      };
    };
  };

  config = lib.mkIf cfg.enable {
    services = {
      xserver = {
        displayManager = {
          gdm = {
            enable = cfg.gdm.enable;
            # wayland = hyprlandEnable;
          };
        };
      };
      displayManager = {
        ly = {
          enable = cfg.ly.enable;
        };
      };
    };
  };
}
