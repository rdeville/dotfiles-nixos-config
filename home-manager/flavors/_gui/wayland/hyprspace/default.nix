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
              enable = lib.mkOption {
                type = lib.types.bool;
                description = "Install ${name} Home-Manager flavor.";
                default = config.hm.flavors.${name}.${subname}.enable;
              };
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
