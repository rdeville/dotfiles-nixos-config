{
  config,
  lib,
  pkgs,
  ...
}: let
  name = builtins.baseNameOf ../../.;
  subname = builtins.baseNameOf ../.;
  subsubname = builtins.baseNameOf ./.;
  cfg = config.hm.flavors.${name}.${subname}.${subsubname};
in {
  options = {
    hm = {
      flavors = {
        ${name} = {
          ${subname} = {
            ${subsubname} = {
              enable = lib.mkEnableOption ''
                Install ${name}.${subname}.${subsubname} Home-Manager flavor.
              '';
            };
          };
        };
      };
    };
  };

  config = lib.mkIf cfg.enable {
    wayland = {
      windowManager = {
        hyprland = {
          plugins = [
            pkgs.hyprlandPlugins.hyprspace
          ];

          settings = {
            bind = [
              "$mod $shift, E, overview:toggle"
            ];
          };
        };
      };
    };
  };
}
