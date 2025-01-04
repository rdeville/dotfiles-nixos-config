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
        };
      };
    };
  };

  config = lib.mkIf cfg.enable {
    services = {
      xserver = {
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
