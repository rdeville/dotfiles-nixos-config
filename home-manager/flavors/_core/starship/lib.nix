{config, ...}: let
  name = builtins.baseNameOf ../.;
  subName = builtins.baseNameOf ./.;

  colors = (import ../../../../colors).material-all.hex;
in {
  inherit colors;

  sep = {
    left = bg: "[](fg:prev_bg bg:${bg})";
    right = bg: "[](fg:${bg} bg:prev_bg)";
  };

  mkGetSarshipModuleConfig = moduleName:
    config.hm.flavors.${name}.${subName}.modules.${moduleName};

  mkSetStarshipModuleOptions = moduleName: options: {
    hm = {
      flavors = {
        ${name} = {
          ${subName} = {
            modules = {
              ${moduleName} = options;
            };
          };
        };
      };
    };
  };
}
