{
  config,
  lib,
  ...
}: let
  name = builtins.baseNameOf ../../.;
  subname = builtins.baseNameOf ../.;
  subsubname = builtins.baseNameOf ./.;
  cfgFlavor = config.hm.flavors.${name};
  cfgModule = cfgFlavor.${subname}.enable;
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
              enable = lib.mkDependEnabledOption ''
                Install ${name}.${subname}.${subsubname} Home-Manager flavor.''
              cfgModule;

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
