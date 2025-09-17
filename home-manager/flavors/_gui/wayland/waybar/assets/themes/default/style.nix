{
  config,
  lib,
  ...
}: let
  name = builtins.baseNameOf ../../../../../.;
  subname = builtins.baseNameOf ../../../../.;
  subsubname = builtins.baseNameOf ../../../.;
  themeName = builtins.baseNameOf ./.;
  cfg = config.hm.flavors.${name}.${subname}.${subsubname};
in
  lib.mkIf (cfg.theme.name == themeName) {
    programs = {
      waybar = {
        style = ''
          /* Colors (gruvbox-material) */
          @define-color foreground #c0caf5;
          @define-color red rgb(251, 44, 54);
          @define-color orange rgb(255, 105, 0);
          @define-color yellow rgb(240, 177, 0);
          @define-color lime rgb(124, 207, 0);
          @define-color green rgb(0, 201, 80);
          @define-color emerald rgb(0, 188, 125);
          @define-color teal rgb(0, 187, 167);
          @define-color cyan rgb(0, 184, 219);
          @define-color sky rgb(0, 166, 244);
          @define-color blue rgb(43, 127, 255);
          @define-color indigo rgb(97, 95, 255);
          @define-color violet rgb(142, 81, 255);
          @define-color purple rgb(173, 70, 255);
          @define-color fuchsia rgb(225, 42, 251);
          @define-color pink rgb(246, 51, 154);
          @define-color rose rgb(255, 32, 86);
          @define-color zinc-light rgb(228, 228, 231);
          @define-color zinc-dark rgb(39, 39, 42);

          @define-color warning @orange;
          @define-color critical @red;

          @keyframes blink-warning {
            70% {
              color: @zinc-light;
            }

            to {
              color: @zinc-light;
              background-color: @orange;
            }
          }

          @keyframes blink-critical {
            70% {
              color: @zinc-light;
            }

            to {
              color: @zinc-light;
              background-color: @red;
            }
          }

          /* Reset all styles */
          * {
            border: none;
            border-radius: 0;
            min-height: 0;
            margin: 0;
            padding: 0;
          }

          /* The whole bar */
          #waybar {
            background: rgba(0, 0, 0, 0);
            color: @zinc-light;
            font-family: FiraCode Nerd Font;
            font-size: 12px;
          }

          /* Apply to each module */
          #battery,
          #clock,
          #cpu,
          #custom-keyboard-layout,
          #memory,
          #submap,
          #network,
          #pulseaudio,
          #temperature,
          #tray {
            margin-left: 2px;
            margin-right: 2px;

            padding-left: 5px;
            padding-right: 5px;
            padding-bottom: 2px;

            border-bottom: 2px solid;
            border-color: @zinc-light;
            /* To compensate for the top border and still have vertical centering */
          }

          #battery.warning.discharging,
          #cpu.warning,
          #memory.warning {
            animation-name: blink-warning;
            animation-duration: 3s;
          }

          #battery.critical.discharging,
          #cpu.critical,
          #memory.critical {
            animation-name: blink-critical;
            animation-duration: 2s;
          }

          #battery.warning,
          #cpu.warning,
          #memory.warning,
          #network.disconnected {
            border-color: @orange;
            color: @orange;
          }

          #battery.critical,
          #cpu.critical,
          #memory.critical {
            border-color: @red;
            color: @red;
          }

          #workspaces button {
            margin-left: 3px;

            padding-left: 5px;
            padding-right: 5px;
            padding-bottom: 2px;

            border-bottom: 2px solid;
            /* To compensate for the bottom border and still have vertical centering */
            padding-top: 2px;

            color: rgba(228, 228, 231, 0.5);
          }

          #workspaces button.active {
            border-color: @lime;
            color: @lime;
          }

          #workspaces button.urgent {
            border-color: @red;
            color: @red;
          }

          #submap {
            border-color: @red;
          }

          #window {
            margin-left: 20px;
            font-weight: bold;
          }

          /* Per modules */
          #battery {
            border-color: @yellow;
          }

          #network {
            border-color: @green;
          }

          #network.speed {
            border-color: @lime;
          }

          #memory {
            border-color: @teal;
          }

          #cpu {
            border-color: @sky;
          }

          #tray {
            border-color: @indigo;
          }

          #clock {
            border-color: @purple;
          }
        '';
      };
    };
  }
