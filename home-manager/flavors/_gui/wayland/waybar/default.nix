{
  config,
  lib,
  ...
}: let
  name = builtins.baseNameOf ../../.;
  subname = builtins.baseNameOf ../.;
  subsubname = builtins.baseNameOf ./.;
  cfg = config.hm.flavors.${name}.${subname}.${subsubname};
in {
  imports = [
    ./assets/themes
  ];

  options = {
    hm = {
      flavors = {
        ${name} = {
          ${subname} = {
            ${subsubname} = {
              enable =
                lib.mkDependEnabledOption ''
                  Install ${name}.${subname}.${subsubname} Home-Manager flavor.
                ''
                (
                  config.hm.flavors.${name}.enable
                  && config.hm.flavors.${name}.${subname}.enable
                  && config.hm.flavors.${name}.${subname}.hyprland.enable
                );

              theme = {
                name = lib.mkOption {
                  type = lib.types.str;
                  description = "Name of the ${subsubname} theme to use.";
                  default = "default";
                };
              };

              battery = {
                enable = lib.mkEnableOption "battery module in waybar";
                bat = lib.mkOption {
                  type = lib.types.str;
                  description = "Battery name as shown in /sys/class/power_supply/";
                  default = "BAT0";
                };
                adapter = lib.mkOption {
                  type = lib.types.str;
                  description = "Adapter name as shown in /sys/class/power_supply/";
                  default = "ACAD";
                };
              };
            };
          };
        };
      };
    };
  };

  config = lib.mkIf cfg.enable {
    programs = {
      waybar = {
        inherit
          (cfg)
          enable
          ;
      };
    };
  };
}
