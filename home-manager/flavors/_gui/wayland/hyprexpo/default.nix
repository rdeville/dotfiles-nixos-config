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
            pkgs.hyprlandPlugins.hyprexpo
          ];

          extraConfig = ''
            plugin {
              hyprexpo {
                columns = 3
                gap_size = 5
                bg_col = rgb(111111)
                # [center/first] [workspace] e.g. first 1 or center m+1
                workspace_method = center current

                enable_gesture = false
              }
            }
          '';

          settings = {
            bind = [
              "$mod, space, hyprexpo:expo, toggle"
            ];
          };
        };
      };
    };
  };
}
