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

              systemd = {
                enable = lib.mkDefaultEnabledOption ''
                  Whether to enable Waybar systemd integration.
                '';
              };

              theme = {
                name = lib.mkOption {
                  type = lib.types.str;
                  description = "Name of the ${subsubname} theme to use.";
                  default = "default";
                };
              };

              battery = lib.mkOption {
                type = lib.types.attr;
                description = ''
                  Configuration of the battery segment. If not null, will
                  display battery information provided by this option in the
                  right of the waybar.
                '';
                default = {};
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
          systemd
          ;
      };
    };
  };
}
