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
          @keyframes blink-warning {
              70% {
                  color: white;
              }
              to {
                  color: white;
                  background-color: orange;
              }
          }
          @keyframes blink-critical {
              70% {
                color: white;
              }
              to {
                  color: white;
                  background-color: red;
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
            background: #323232;
            color: white;
            font-family: ${config.hm.flavors._gui.font.name};
            font-size: ${builtins.toString (config.hm.flavors._gui.font.size)}px;
          }

          #workspaces button {
            color: #dddddd;
          }

          #workspaces button.active {
            color: #44dd00;
          }

          #submap {
            background-color: #ff5555;
            color: #dddddd;
          }

          /* Each module */
          #battery,
          #clock,
          #cpu,
          #custom-keyboard-layout,
          #memory,
          #mode,
          #network,
          #pulseaudio,
          #temperature,
          #tray {
            padding-left: 1rem;
          }

          #cpu.warning {
            color: orange;
          }

          #cpu.critical {
            color: red;
          }

          #memory {
            animation-timing-function: linear;
            animation-iteration-count: infinite;
            animation-direction: alternate;
          }

          #memory.warning {
            color: orange;
          }

          #memory.critical {
            color: red;
            animation-name: blink-critical;
            animation-duration: 2s;
          }

          #mode {
            background: #64727D;
            border-top: 2px solid white;
            /* To compensate for the top border and still have vertical centering */
            padding-bottom: 2px;
          }

          #network.disconnected {
            color: orange;
          }

          #tray {
            /* No styles */
          }

          #workspaces button {
            border-top: 2px solid transparent;
            /* To compensate for the top border and still have vertical centering */
            padding-bottom: 2px;
            color: #888888;
          }

          #workspaces button.focused {
            border-color: #4c7899;
            color: white;
            background-color: #285577;
          }

          #workspaces button.urgent {
            border-color: #c9545d;
            color: #c9545d;
          }
        '';
      };
    };
  }
