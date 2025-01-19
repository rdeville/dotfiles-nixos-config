{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: let
  name = builtins.baseNameOf ../../.;
  subname = builtins.baseNameOf ../.;
  subsubname = builtins.baseNameOf ./.;
  cfg = config.hm.flavors.${name}.${subname}.${subsubname};
  clr = config.colors.material.hex;
in {
  options = {
    hm = {
      flavors = {
        ${name} = {
          ${subname} = {
            ${subsubname} = {
              enable = lib.mkOption {
                type = lib.types.bool;
                description = "Install ${name}.${subname}.${subsubname} Home-Manager flavor.";
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
      packages = with pkgs; [
        wl-kbptr
        wlrctl
      ];
    };

    wayland = {
      windowManager = {
        hyprland = {
          extraConfig = ''
            # wl-kbptr
            # ----------------------------------------------------
            bind=$mod,a,exec,wl-kbptr
            # Cursor submap (similar to the Mouse mode in Sway)
            submap=cursor

            # wl-kbptr
            # Jump cursor to a position
            bind=,a,exec,hyprctl dispatch submap reset && wl-kbptr && hyprctl dispatch submap cursor

            # Cursor movement
            binde=,j,exec,wlrctl pointer move 0 100
            binde=,k,exec,wlrctl pointer move 0 -100
            binde=,l,exec,wlrctl pointer move 100 0
            binde=,h,exec,wlrctl pointer move -100 0
            binde=$shift,j,exec,wlrctl pointer move 0 25
            binde=$shift,k,exec,wlrctl pointer move 0 -25
            binde=$shift,l,exec,wlrctl pointer move 25 0
            binde=$shift,h,exec,wlrctl pointer move -25 0

            # Left button
            bind=,s,exec,wlrctl pointer click left
            # Middle button
            bind=,d,exec,wlrctl pointer click middle
            # Right button
            bind=,f,exec,wlrctl pointer click right

            # Exit cursor submap
            # If you do not use cursor timeout or cursor:hide_on_key_press, you can delete its respective cals
            bind=,escape,exec,hyprctl keyword cursor:inactive_timeout 3; hyprctl keyword cursor:hide_on_key_press true; hyprctl dispatch submap reset

            submap = reset

            # Entrypoint
            # If you do not use cursor timeout or cursor:hide_on_key_press, you can delete its respective cals
            bind=$mod,g,exec,hyprctl keyword cursor:inactive_timeout 0; hyprctl keyword cursor:hide_on_key_press false; hyprctl dispatch submap cursor
          '';
        };
      };
    };

    xdg = {
      configFile = {
        "wl-kbptr/config" = {
          text = ''
            # wl-kbptr can be configured with a configuration file.
            # The file location can be passed with the -C parameter.
            # Othewise the `$XDG_CONFIG_HOME/wl-kbptr/config` file will
            # be loaded if it exits. Below is the default configuration.

            # [general]
            # home_row_keys="qsdfghjklm"

            # grey_300 = "${clr.grey_300}";
            # grey_700 = "${clr.grey_700}";
            # light_green_A400 = "${clr.light_green_A400}";
            # light_green_600 = "${clr.light_green_600}";
            # light_green_800 = "${clr.light_green_800}";
            # light_blue_600 = "${clr.light_blue_600}";
            # light_blue_800 = "${clr.light_blue_800}";
            # red_A200 = "${clr.red_A200}";

            [mode_tile]
            label_color=${clr.grey_300}90
            label_select_color=${clr.light_green_A400}ff
            unselectable_bg_color=${clr.grey_700}00
            selectable_bg_color=${clr.light_green_800}20
            selectable_border_color=${clr.light_green_600}90

            [mode_bisect]
            label_color=${clr.light_green_A400}ff
            label_font_size=20
            label_padding=20
            pointer_size=20
            pointer_color=${clr.red_A200}
            unselectable_bg_color=${clr.grey_700}00
            even_area_bg_color=${clr.light_green_800}20
            even_area_border_color=${clr.light_green_600}90
            odd_area_bg_color=${clr.light_blue_800}20
            odd_area_border_color=${clr.light_blue_600}90

            history_border_color=${clr.red_A200}

            # set ft=toml
          '';
        };
      };
    };
  };
}
