{
  config,
  lib,
  ...
}: let
  name = builtins.baseNameOf ../.;
  subname = builtins.baseNameOf ./.;
  cfg = config.hm.flavors.${name}.${subname};
in {
  options = {
    hm = {
      flavors = {
        ${name} = {
          ${subname} = {
            enable =
              lib.mkDependEnabledOption ''
                Install ${name}.${subname} Home-Manager flavor.
              ''
              config.hm.flavors.${name}.enable;
          };
        };
      };
    };
  };

  config = lib.mkIf cfg.enable {
    programs = {
      mr = {
        enable = true;
      };
    };

    xdg = {
      configFile = {
        mr = {
          source = ./lib;
        };
      };
    };

    home = {
      file = {
        ".mrconfig" = lib.mkForce {
          source = ./mrconfig;
        };
      };
    };
  };
}
