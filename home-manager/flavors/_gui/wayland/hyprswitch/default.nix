{
  inputs,
  config,
  lib,
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
    home = {
      packages = [
        inputs.hyprswitch.packages.${config.hm.system}.default
      ];
    };

    wayland = {
      windowManager = {
        hyprland = {
          extraConfig = ''
            # hyprswitch
            # ----------------------------------------------------
            exec-once=hyprswitch init --show-title --size-factor 5.5 --workspaces-per-row 5 &

            # submap, a custom mode for hyprswitch
            submap=hyprswitch

            submap=reset

            # Entrypoint
            # If you do not use cursor timeout or cursor:hide_on_key_press, you can delete its respective cals
            # bind=$mod,g,exec,hyprctl keyword cursor:inactive_timeout 0; hyprctl keyword cursor:hide_on_key_press false; hyprctl dispatch submap cursor
          '';

          settings = {
            bind = [
              "$mod, $tab, exec, hyprswitch gui --mod-key $mod --key $tab --max-switch-offset 9 --hide-active-window-border"
            ];
          };
        };
      };
    };
  };
}
