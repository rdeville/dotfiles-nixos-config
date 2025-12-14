{
  config,
  pkgs,
  lib,
  ...
}: let
  name = builtins.baseNameOf ../../.;
  subname = builtins.baseNameOf ../.;
  subsubname = builtins.baseNameOf ./.;
  cfg = config.hm.flavors.${name}.${subname}.${subsubname};
  clr = config.colors.material;
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
                );

              plugins = lib.mkOption {
                type = with lib.types; listOf (either package path);
                description = ''
                  List of Hyprland default plugins to use.
                  Can either be packages or absolute plugin paths.
                '';
                default = [];
              };

              extraSettings = lib.mkOption {
                type = with lib.types; let
                  valueType =
                    nullOr (oneOf [
                      bool
                      int
                      float
                      str
                      path
                      (attrsOf valueType)
                      (listOf valueType)
                    ])
                    // {
                      description = "Hyprland configuration value";
                    };
                in
                  valueType;
                description = ''
                  Hyprland extra configuration written in Nix added to the default
                  settings.
                '';
                default = {};
              };

              extraConfig = lib.mkOption {
                type = lib.types.lines;
                description = ''
                  Extra configuration lines to add to
                  `${config.xdg.configHome}/hypr/hyprland.conf`.
                '';
                default = "";
              };

              theme = {
                name = lib.mkOption {
                  type = lib.types.str;
                  description = "Name of the theme to install";
                  default = "default";
                };
              };

              systemd = {
                enableXdgAutostart = lib.mkDefaultEnabledOption ''
                  Whether to enable autostart of applications using {manpage};
                  `systemd-xdg-autostart-generator(8)`.
                  boolean
                '';
              };
            };
          };
        };
      };
    };
  };

  config = let
    scriptPath = "hypr/scripts";
  in
    lib.mkIf cfg.enable
    {
      home = {
        packages = with pkgs; [
          kitty
          hyprpolkitagent
          nwg-displays
          pipewire
          wireplumber
          grim
          slurp
        ];
      };

      xdg = {
        configFile = {
          "${scriptPath}" = {
            source = ./assets/scripts;
          };
        };
      };

      programs = {
        hyprshot = {
          enable = true;
          saveLocation = "$HOME/screenshots";
        };
      };

      wayland = {
        windowManager = {
          hyprland = {
            inherit
              (cfg)
              enable
              systemd
              ;

            xwayland = {
              enable = true;
            };

            inherit (cfg) plugins;

            extraConfig =
              ''
                windowrule = bordercolor rgba(${clr.str.red_600}ee) rgba(${clr.str.purple_400}ee) 45deg,fullscreen:1
                windowrule = bordercolor rgba(${clr.str.yellow_600}ee) rgba(${clr.str.amber_400}ee) 45deg,floating:1

                exec-once=systemctl --user start hyprpolkitagent
                exec-once=systemctl --user start xdg-desktop-portal-hyprland
                exec-once=dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
              ''
              + (
                if config.hm.flavors._gui.wayland.waybar.enable
                then ''
                  exec-once=sleep 2 && systemctl --user restart waybar.service
                ''
                else ""
              )
              + (
                if config.hm.flavors._gui.wayland.swww.enable
                then ''
                  exec-once=swww-daemon
                ''
                else ""
              )
              + cfg.extraConfig;

            settings =
              {
                "$terminal" = "kitty";
                "$menu" = "rofi";
                "$mod" = "super";
                "$tab" = "tab";
                "$ctrl" = "ctrl";
                "$alt" = "alt";
                "$shift" = "shift";

                general = {
                  border_size = 2;
                  no_border_on_floating = false;
                  gaps_in = 5;
                  gaps_out = 10;
                  "col.active_border" = "rgba(${clr.str.cyan_A400}ee) rgba(${clr.str.green_A400}ee) 45deg";
                  "col.inactive_border" = "rgba(${clr.str.grey_900}aa)";
                  layout = "master";
                };

                # Cursor Config
                cursor = {
                  inactive_timeout = 30;
                };

                # Window decoration
                decoration = {
                  rounding = 5;
                };

                # Window Tabbed Groups
                group = {
                  auto_group = false;
                  "col.border_active" = "rgba(${clr.str.cyan_A400}ee) rgba(${clr.str.green_A400}ee) 45deg";
                  "col.border_inactive" = "rgba(${clr.str.grey_900}aa)";
                  groupbar = {
                    render_titles = false;
                    indicator_height = 5;
                    "col.active" = "rgba(${clr.str.cyan_A400}ee)";
                    "col.inactive" = "rgba(${clr.str.grey_900}aa)";
                  };
                };

                input = {
                  kb_layout = "fr";
                  kb_options = "caps:escape";
                };
                # Keyboard Binding
                # bind supports flags in this format:
                # bind[flags] = ...
                # Flags:
                # l -> locked, will also work when an input inhibitor (e.g. a lockscreen) is active.
                # r -> release, will trigger on release of a key.
                # o -> longPress, will trigger on long press of a key.
                # e -> repeat, will repeat when held.
                # n -> non-consuming, key/mouse events will be passed to the active window in addition to triggering the dispatcher.
                # m -> mouse, see below.
                # t -> transparent, cannot be shadowed by other binds.
                # i -> ignore mods, will ignore modifiers.
                # s -> separate, will arbitrarily combine keys between each mod/key, see [Keysym combos](#keysym-combos) above.
                # d -> has description, will allow you to write a description for your bind.
                # p -> bypasses the app's requests to inhibit keybinds.
                bind =
                  [
                    "$mod $shift, Q, exec, $menu -show power-menu -modi 'power-menu:rofi-power-menu --confirm=shutdown/reboot'"
                    "$mod, q, exec, hyprlock"
                    "$mod $shift, R, exec, ${config.xdg.configHome}/${scriptPath}/process hyprland reload"
                  ]
                  ++ [
                    (
                      if config.hm.flavors._gui.wayland.waybar.enable
                      then "$mod, b, exec, ${config.xdg.configHome}/${scriptPath}/process waybar toggle"
                      else ""
                    )
                  ]
                  ++ [
                    "$mod $ctrl, C, killactive,"
                    "$mod, Return, exec, $terminal"

                    # Layout Toggle
                    "$mod, space, exec, hyprctl keyword general:layout \"$(hyprctl getoption general:layout | grep -q 'dwindle' && echo 'master' || echo 'dwindle')\""

                    # Window Groups
                    "$mod       , t, togglegroup"
                    "$mod       , tab, changegroupactive, b"
                    "$mod $shift, tab, changegroupactive, f"
                    "$mod $ctrl, h, moveintogroup, l"

                    "$mod $ctrl, l, moveintogroup, r"
                    "$mod $ctrl, k, moveintogroup, u"
                    "$mod $ctrl, j, moveintogroup, d"
                    "$mod, escape, moveoutofgroup, active"
                    # Window management
                    "$mod, M, fullscreen, 1"
                    "$mod, F, togglefloating,"
                    "$mod, s, pin"
                    # Move focus
                    "$mod, u, focusurgentorlast"
                    "$mod, h, movefocus, l"
                    "$mod, l, movefocus, r"
                    "$mod, k, movefocus, u"
                    "$mod, j, movefocus, d"
                    # Move window position
                    "$mod $shift, h, movewindow, l"
                    "$mod $shift, l, movewindow, r"
                    "$mod $shift, k, movewindow, u"
                    "$mod $shift, j, movewindow, d"
                    # Switch workspaces with mainMod [0-9]
                    "$mod, code:10, exec, hyprctl dispatch moveworkspacetomonitor 1 current && hyprctl dispatch workspace 1"
                    "$mod, code:11, exec, hyprctl dispatch moveworkspacetomonitor 2 current && hyprctl dispatch workspace 2"
                    "$mod, code:12, exec, hyprctl dispatch moveworkspacetomonitor 3 current && hyprctl dispatch workspace 3"
                    "$mod, code:13, exec, hyprctl dispatch moveworkspacetomonitor 4 current && hyprctl dispatch workspace 4"
                    "$mod, code:14, exec, hyprctl dispatch moveworkspacetomonitor 5 current && hyprctl dispatch workspace 5"
                    "$mod, code:15, exec, hyprctl dispatch moveworkspacetomonitor 6 current && hyprctl dispatch workspace 6"
                    "$mod, code:16, exec, hyprctl dispatch moveworkspacetomonitor 7 current && hyprctl dispatch workspace 7"
                    "$mod, code:17, exec, hyprctl dispatch moveworkspacetomonitor 8 current && hyprctl dispatch workspace 8"
                    "$mod, code:18, exec, hyprctl dispatch moveworkspacetomonitor 9 current && hyprctl dispatch workspace 9"
                    "$mod, code:19, exec, hyprctl dispatch moveworkspacetomonitor 10 current && hyprctl dispatch workspace 10"
                    "$mod, z, workspace, -1"
                    "$mod, o, workspace, +1"
                    # Move active window to a workspace with mainMod $shift [0-9]
                    "$mod $shift, code:10, movetoworkspacesilent, 1"
                    "$mod $shift, code:11, movetoworkspacesilent, 2"
                    "$mod $shift, code:12, movetoworkspacesilent, 3"
                    "$mod $shift, code:13, movetoworkspacesilent, 4"
                    "$mod $shift, code:14, movetoworkspacesilent, 5"
                    "$mod $shift, code:15, movetoworkspacesilent, 6"
                    "$mod $shift, code:16, movetoworkspacesilent, 7"
                    "$mod $shift, code:17, movetoworkspacesilent, 8"
                    "$mod $shift, code:18, movetoworkspacesilent, 9"
                    "$mod $shift, code:19, movetoworkspacesilent, 10"
                    # Move active window to a workspace with mainMod $shift [0-9]
                    # and focus follow
                    "$mod $ctrl, code:10, movetoworkspace, 1"
                    "$mod $ctrl, code:11, movetoworkspace, 2"
                    "$mod $ctrl, code:12, movetoworkspace, 3"
                    "$mod $ctrl, code:13, movetoworkspace, 4"
                    "$mod $ctrl, code:14, movetoworkspace, 5"
                    "$mod $ctrl, code:15, movetoworkspace, 6"
                    "$mod $ctrl, code:16, movetoworkspace, 7"
                    "$mod $ctrl, code:17, movetoworkspace, 8"
                    "$mod $ctrl, code:18, movetoworkspace, 9"
                    "$mod $ctrl, code:19, movetoworkspace, 10"

                    # Rofi
                    "$mod, R, exec, pkill $menu || $menu -show drun -show-icons"
                    "$mod, I, exec, ${config.xdg.configHome}/rofi/scripts/menu gitmoji"
                    "$mod, E, exec, ${config.xdg.configHome}/rofi/scripts/menu emoji"
                    "$mod, N, exec, ${config.xdg.configHome}/rofi/scripts/menu nerdfont"

                    # Hyprshot
                    # Screenshot a window
                    "$mod, p, exec, hyprshot -m window"
                    # Screenshot a monitor
                    "$mod $shift, p, exec, hyprshot -m output"
                    # Screenshot a region
                    "$mod $ctrl, p, exec, hyprshot -m region"
                  ];

                binde = [
                  # Window Resize
                  "$mod $alt, h, resizeactive, -40 0"
                  "$mod $alt, l, resizeactive, 40 0"
                  "$mod $alt, k, resizeactive, 0 -40"
                  "$mod $alt, j, resizeactive, 0 40"
                  "$mod, left, moveactive, -100 0"
                  "$mod, right, moveactive, 100 0"
                  "$mod, up, moveactive, 0 -100"
                  "$mod, down, moveactive, 0 100"
                ];

                bindle = [
                  ", XF86MonBrightnessUp, exec, brightnessctl s +5%"
                  ", XF86MonBrightnessDown, exec, brightnessctl s 5%-"
                  ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
                  ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
                  ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
                ];
                # Move/Resize windows with mainMod LMB/RMB and dragging
                bindm = [
                  "$mod, mouse:272, movewindow"
                  "$mod, mouse:273, resizewindow"
                ];

                animations = {
                  enabled = true;
                };
              }
              // cfg.extraSettings;
          };
        };
      };
    };
}
