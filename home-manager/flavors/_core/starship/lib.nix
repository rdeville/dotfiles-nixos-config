{config, ...}: let
  name = builtins.baseNameOf ../.;
  subname = builtins.baseNameOf ./.;
  cfg = config.hm.flavors.${name}.${subname};

  colors = config.colors.material.hex;
in {
  inherit colors;

  sep = {
    left = bg: "[](fg:prev_bg bg:${bg})";
    right = bg: "[](fg:${bg} bg:prev_bg)";
  };

  mkGetSarshipModuleConfig = moduleName:
    cfg.modules.${moduleName};

  mkSetStarshipModuleOptions = moduleName: options: {
    hm = {
      flavors = {
        ${name} = {
          ${subname} = {
            modules = {
              ${moduleName} = options;
            };
          };
        };
      };
    };
  };
}
