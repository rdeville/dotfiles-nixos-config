{
  config,
  lib,
  ...
}: let
  name = builtins.baseNameOf ./.;
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

            settings = lib.mkOption {
              type = lib.types.attrs;
              description = "Settings for ly display manager.";
              default = {
                animation = "matrix";
              };
            };
          };

          xkb = {
            layout = lib.mkOption {
              type = lib.types.str;
              description = "Layout to apply with x11.";
              default = config.os.console.keyMap;
            };
            options = lib.mkOption {
              type = lib.types.str;
              description = "X keyboard option to apply.";
              default = "caps:escape";
            };
          };
        };
      };
    };
  };

  config = lib.mkIf (! config.os.isDarwin && cfg.enable) {
    services = {
      xserver = {
        inherit (cfg) xkb;
        enable = true;
        displayManager = {
          gdm = {
            inherit (cfg.gdm) enable;
          };
        };
      };
      displayManager = {
        ly = {
          inherit (cfg.ly) enable settings;
        };
      };
    };
  };
}
