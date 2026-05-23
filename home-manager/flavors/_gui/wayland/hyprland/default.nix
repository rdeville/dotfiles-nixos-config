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

  generalConfig = {
    general = {
      border_size = 2;
      gaps_in = 5;
      gaps_out = 10;
      "col.active_border" = {
        colors = ["rgba(${clr.str.cyan_A400}ee)" "rgba(${clr.str.green_A400}ee)"];
        angle = 45;
      };
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
      "col.border_active" = {
        colors = ["rgba(${clr.str.cyan_A400}ee)" "rgba(${clr.str.green_A400}ee)"];
        angle = 45;
      };
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
  };
in {
  imports = [
    ./options.nix
  ];

  config = let
    scriptPath = "hypr/scripts";

    # ── Lua helpers ───────────────────────────────────────────────────────────
    mkLua = lib.generators.mkLuaInline;

    # Build a Lua key-combo string from a list of modifier variable names and a
    # literal key name.  e.g. mkKey ["mod" "shift"] "Q" →
    #   mkLua "mod .. \" + \" .. shift .. \" + Q\""  →  Lua: "SUPER + SHIFT + Q"
    mkKey = mods: k:
      mkLua (lib.concatStringsSep " .. \" + \" .. " (mods ++ ["\"${k}\""]));

    # Bind entry helpers
    mkBind = key: disp: {_args = [key disp];};
    mkBindF = key: disp: flags: {_args = [key disp flags];};

    # exec_cmd dispatcher from a plain Nix string (properly JSON-escaped for Lua)
    execStr = cmd: mkLua "hl.dsp.exec_cmd(${builtins.toJSON cmd})";

    # exec_cmd dispatcher from a Lua expression (e.g. one using a Lua variable)
    execLua = expr: mkLua "hl.dsp.exec_cmd(${expr})";
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
              configType
              ;

            xwayland = {
              enable = true;
            };

            inherit (cfg) plugins;

            extraConfig =
              if cfg.configType == "lua"
              then
                # In Lua mode all startup/rules/animation live in `settings`.
                cfg.extraConfig
              else
                ''
                  windowrule = border_color rgba(${clr.str.red_600}ee) rgba(${clr.str.purple_400}ee) 45deg,match:fullscreen true
                  windowrule = border_color rgba(${clr.str.yellow_600}ee) rgba(${clr.str.amber_400}ee) 45deg,match:float true

                  exec-once=systemctl --user start hyprpolkitagent
                  exec-once=systemctl --user start xdg-desktop-portal-hyprland
                  exec-once=dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP

                  animation = global, 1, 2.5,    default
                ''
                + (
                  if config.hm.flavors._gui.wayland.waybar.enable
                  then ''
                    exec-once=sleep 2 && systemctl --user restart waybar.service
                  ''
                  else ""
                )
                + (
                  if config.hm.flavors._gui.wayland.awww.enable
                  then ''
                    exec-once=awww-daemon
                  ''
                  else ""
                )
                + lib.concatMapStrings (cmd: "exec-once=${cmd}\n") cfg.startupCommands
                + lib.concatMapStrings (
                  m:
                    if m.disabled
                    then "monitor=${m.output},disable\n"
                    else
                      "monitor=${m.output},${m.mode},${m.position},${toString m.scale}"
                      + lib.optionalString (m.transform != null) ",transform,${toString m.transform}"
                      + lib.optionalString (m.mirror != null) ",mirror,${m.mirror}"
                      + "\n"
                )
                cfg.monitorConfig
                + cfg.extraConfig;

            settings =
              if cfg.configType == "lua"
              then
                {
                  # ── Variables ───────────────────────────────────────────────
                  mod._var = "SUPER";
                  terminal._var = "kitty";
                  menu._var = "rofi";
                  ctrl._var = "CTRL";
                  alt._var = "ALT";
                  shift._var = "SHIFT";

                  # ── General config ──────────────────────────────────────────
                  config = generalConfig // {animations = {enabled = true;};};

                  # ── Global animation ────────────────────────────────────────
                  animation = {
                    leaf = "global";
                    enabled = true;
                    speed = 2.5;
                    bezier = "default";
                  };

                  # ── Window rules ────────────────────────────────────────────
                  window_rule = [
                    {
                      match = {fullscreen = true;};
                      border_color = {
                        colors = ["rgba(${clr.str.red_600}ee)" "rgba(${clr.str.purple_400}ee)"];
                        angle = 45;
                      };
                    }
                    {
                      match = {float = true;};
                      border_color = {
                        colors = ["rgba(${clr.str.yellow_600}ee)" "rgba(${clr.str.amber_400}ee)"];
                        angle = 45;
                      };
                    }
                  ];

                  # ── Startup hook ────────────────────────────────────────────
                  on = {
                    _args = [
                      "hyprland.start"
                      (mkLua (
                        lib.concatStrings (
                          [
                            "function()\n"
                            "  hl.exec_cmd(\"systemctl --user start hyprpolkitagent\")\n"
                            "  hl.exec_cmd(\"systemctl --user start xdg-desktop-portal-hyprland\")\n"
                            "  hl.exec_cmd(\"dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP\")\n"
                          ]
                          ++ lib.optional config.hm.flavors._gui.wayland.waybar.enable
                          "  hl.exec_cmd(\"sleep 2 && systemctl --user restart waybar.service\")\n"
                          ++ lib.optional config.hm.flavors._gui.wayland.awww.enable
                          "  hl.exec_cmd(\"awww-daemon\")\n"
                          ++ lib.map (cmd: "  hl.exec_cmd(${builtins.toJSON cmd})\n") cfg.startupCommands
                          ++ ["end"]
                        )
                      ))
                    ];
                  };

                  # ── Keybinds ────────────────────────────────────────────────
                  bind =
                    [
                      # System
                      (mkBind (mkKey ["mod" "shift"] "Q") (execLua "menu .. \" -show power-menu -modi 'power-menu:rofi-power-menu --confirm=shutdown/reboot'\""))
                      (mkBind (mkKey ["mod"] "Q") (execStr "hyprlock"))
                      (mkBind (mkKey ["mod" "shift"] "R") (execStr "${config.xdg.configHome}/${scriptPath}/process hyprland reload"))
                    ]
                    ++ lib.optionals config.hm.flavors._gui.wayland.waybar.enable [
                      (mkBind (mkKey ["mod"] "B") (execStr "${config.xdg.configHome}/${scriptPath}/process waybar toggle"))
                    ]
                    ++ [
                      # Window management
                      (mkBind (mkKey ["mod" "ctrl"] "C") (mkLua "hl.dsp.window.close()"))
                      (mkBind (mkKey ["mod"] "RETURN") (execLua "terminal"))
                      (mkBind (mkKey ["mod"] "SPACE") (execStr ''hyprctl keyword general:layout "$(hyprctl getoption general:layout | grep -q 'dwindle' && echo 'master' || echo 'dwindle')"''))

                      # Window groups
                      (mkBind (mkKey ["mod"] "T") (mkLua "hl.dsp.group.toggle()"))
                      (mkBind (mkKey ["mod"] "TAB") (mkLua "hl.dsp.group.prev()"))
                      (mkBind (mkKey ["mod" "shift"] "TAB") (mkLua "hl.dsp.group.next()"))
                      (mkBind (mkKey ["mod" "ctrl"] "H") (mkLua "hl.dsp.window.move({ into_group = \"l\" })"))
                      (mkBind (mkKey ["mod" "ctrl"] "L") (mkLua "hl.dsp.window.move({ into_group = \"r\" })"))
                      (mkBind (mkKey ["mod" "ctrl"] "K") (mkLua "hl.dsp.window.move({ into_group = \"u\" })"))
                      (mkBind (mkKey ["mod" "ctrl"] "J") (mkLua "hl.dsp.window.move({ into_group = \"d\" })"))
                      (mkBind (mkKey ["mod"] "ESCAPE") (mkLua "hl.dsp.window.move({ out_of_group = true })"))

                      # Window state
                      (mkBind (mkKey ["mod"] "M") (mkLua "hl.dsp.window.fullscreen({ mode = \"maximized\" })"))
                      (mkBind (mkKey ["mod"] "F") (mkLua "hl.dsp.window.float({ action = \"toggle\" })"))
                      (mkBind (mkKey ["mod"] "S") (mkLua "hl.dsp.window.pin()"))

                      # Focus
                      (mkBind (mkKey ["mod"] "U") (mkLua "hl.dsp.focus({ urgent_or_last = true })"))
                      (mkBind (mkKey ["mod"] "H") (mkLua "hl.dsp.focus({ direction = \"l\" })"))
                      (mkBind (mkKey ["mod"] "L") (mkLua "hl.dsp.focus({ direction = \"r\" })"))
                      (mkBind (mkKey ["mod"] "K") (mkLua "hl.dsp.focus({ direction = \"u\" })"))
                      (mkBind (mkKey ["mod"] "J") (mkLua "hl.dsp.focus({ direction = \"d\" })"))

                      # Move window
                      (mkBind (mkKey ["mod" "shift"] "H") (mkLua "hl.dsp.window.move({ direction = \"l\" })"))
                      (mkBind (mkKey ["mod" "shift"] "L") (mkLua "hl.dsp.window.move({ direction = \"r\" })"))
                      (mkBind (mkKey ["mod" "shift"] "K") (mkLua "hl.dsp.window.move({ direction = \"u\" })"))
                      (mkBind (mkKey ["mod" "shift"] "J") (mkLua "hl.dsp.window.move({ direction = \"d\" })"))

                      # Relative workspace
                      (mkBind (mkKey ["mod"] "Z") (mkLua "hl.dsp.focus({ workspace = \"-1\" })"))
                      (mkBind (mkKey ["mod"] "O") (mkLua "hl.dsp.focus({ workspace = \"+1\" })"))

                      # Rofi
                      (mkBind (mkKey ["mod"] "R") (execLua "\"pkill \" .. menu .. \" || \" .. menu .. \" -show drun -show-icons\""))
                      (mkBind (mkKey ["mod"] "I") (execStr "${config.xdg.configHome}/rofi/scripts/menu gitmoji"))
                      (mkBind (mkKey ["mod"] "E") (execStr "${config.xdg.configHome}/rofi/scripts/menu emoji"))
                      (mkBind (mkKey ["mod"] "N") (execStr "${config.xdg.configHome}/rofi/scripts/menu nerdfont"))

                      # Hyprshot
                      (mkBind (mkKey ["mod"] "P") (execStr "hyprshot -m window"))
                      (mkBind (mkKey ["mod" "shift"] "P") (execStr "hyprshot -m output"))
                      (mkBind (mkKey ["mod" "ctrl"] "P") (execStr "hyprshot -m region"))
                    ]
                    # Workspace switch: mod+1-0 → move workspace to current monitor then focus
                    ++ lib.map (n:
                      mkBind
                      (mkLua "mod .. \" + code:${toString (n + 9)}\"")
                      (mkLua (
                        lib.concatStrings [
                          "function()\n"
                          "  hl.dispatch(hl.dsp.workspace.move({ workspace = ${toString n}, monitor = \"current\" }))\n"
                          "  hl.dispatch(hl.dsp.focus({ workspace = ${toString n} }))\n"
                          "end"
                        ]
                      ))) (lib.range 1 10)
                    # Move active window to workspace silently: mod+shift+1-0
                    ++ lib.map (n:
                      mkBind
                      (mkLua "mod .. \" + \" .. shift .. \" + code:${toString (n + 9)}\"")
                      (mkLua "hl.dsp.window.move({ workspace = ${toString n}, follow = false })"))
                    (lib.range 1 10)
                    # Move active window to workspace with focus: mod+ctrl+1-0
                    ++ lib.map (n:
                      mkBind
                      (mkLua "mod .. \" + \" .. ctrl .. \" + code:${toString (n + 9)}\"")
                      (mkLua "hl.dsp.window.move({ workspace = ${toString n}, follow = true })"))
                    (lib.range 1 10)
                    # Resize window (was binde)
                    ++ [
                      (mkBindF (mkKey ["mod" "alt"] "H") (mkLua "hl.dsp.window.resize({ x = -40, y = 0, relative = true })") {repeating = true;})
                      (mkBindF (mkKey ["mod" "alt"] "L") (mkLua "hl.dsp.window.resize({ x = 40, y = 0, relative = true })") {repeating = true;})
                      (mkBindF (mkKey ["mod" "alt"] "K") (mkLua "hl.dsp.window.resize({ x = 0, y = -40, relative = true })") {repeating = true;})
                      (mkBindF (mkKey ["mod" "alt"] "J") (mkLua "hl.dsp.window.resize({ x = 0, y = 40, relative = true })") {repeating = true;})
                      (mkBindF (mkKey ["mod"] "left") (mkLua "hl.dsp.window.move({ x = -100, y = 0, relative = true })") {repeating = true;})
                      (mkBindF (mkKey ["mod"] "right") (mkLua "hl.dsp.window.move({ x = 100, y = 0, relative = true })") {repeating = true;})
                      (mkBindF (mkKey ["mod"] "up") (mkLua "hl.dsp.window.move({ x = 0, y = -100, relative = true })") {repeating = true;})
                      (mkBindF (mkKey ["mod"] "down") (mkLua "hl.dsp.window.move({ x = 0, y = 100, relative = true })") {repeating = true;})
                    ]
                    # Media / brightness keys (was bindle)
                    ++ [
                      (mkBindF "XF86MonBrightnessUp" (execStr "brightnessctl s +5%") {
                        repeating = true;
                        locked = true;
                      })
                      (mkBindF "XF86MonBrightnessDown" (execStr "brightnessctl s 5%-") {
                        repeating = true;
                        locked = true;
                      })
                      (mkBindF "XF86AudioRaiseVolume" (execStr "wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+") {
                        repeating = true;
                        locked = true;
                      })
                      (mkBindF "XF86AudioLowerVolume" (execStr "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-") {
                        repeating = true;
                        locked = true;
                      })
                      (mkBindF "XF86AudioMute" (execStr "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle") {
                        repeating = true;
                        locked = true;
                      })
                    ]
                    # Mouse window drag/resize (was bindm)
                    ++ [
                      (mkBindF (mkKey ["mod"] "mouse:272") (mkLua "hl.dsp.window.drag()") {mouse = true;})
                      (mkBindF (mkKey ["mod"] "mouse:273") (mkLua "hl.dsp.window.resize()") {mouse = true;})
                    ];
                }
                // lib.optionalAttrs (cfg.monitorConfig != []) {
                  monitor =
                    lib.map (
                      m:
                        {inherit (m) output mode position scale;}
                        // lib.optionalAttrs m.disabled {disabled = true;}
                        // lib.optionalAttrs (m.transform != null) {transform = m.transform;}
                        // lib.optionalAttrs (m.mirror != null) {mirror = m.mirror;}
                        // lib.optionalAttrs (m.bitdepth != null) {bitdepth = m.bitdepth;}
                        // lib.optionalAttrs (m.vrr != null) {vrr = m.vrr;}
                    )
                    cfg.monitorConfig;
                }
                // cfg.extraSettings
              else
                lib.warn
                "hm.flavors.${name}.${subname}.${subsubname}: configType = \"hyprlang\" is deprecated, migrate to \"lua\""
                (
                  {
                    "$terminal" = "kitty";
                    "$menu" = "rofi";
                    "$mod" = "super";
                    "$tab" = "tab";
                    "$ctrl" = "ctrl";
                    "$alt" = "alt";
                    "$shift" = "shift";

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
                        # Move active window to a workspace with mainMod $ctrl [0-9]
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
                        "$mod, p, exec, hyprshot -m window"
                        "$mod $shift, p, exec, hyprshot -m output"
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

                    bindm = [
                      "$mod, mouse:272, movewindow"
                      "$mod, mouse:273, resizewindow"
                    ];

                    animations = {
                      enabled = true;
                    };
                  }
                  // generalConfig
                  // cfg.extraSettings
                );
          };
        };
      };
    };
}
