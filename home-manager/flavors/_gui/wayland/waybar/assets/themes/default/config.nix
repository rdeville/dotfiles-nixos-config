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
        settings = [
          {
            layer = "top";
            position = "top";
            height = 20;

            modules-left = [
              "hyprland/workspaces"
              "hyprland/submap"
              "hyprland/window"
            ];

            modules-right = [
              "network"
              "memory"
              "cpu"
              "tray"
              "clock"
            ];

            clock = {
              interval = 30;
              format = " {:%e %b %Y | %H:%M}";
              tooltip = false;
            };

            cpu = {
              interval = 5;
              format = " {usage:02d}% {load}";
              states = {
                warning = 70;
                critical = 90;
              };
            };

            memory = {
              interval = 5;
              format = " {usage:02d}%";
              states = {
                warning = 70;
                critical = 90;
              };
            };

            network = {
              interval = 5;
              format-wifi = " {essid} ({signalStrength}%)";
              format-ethernet = "󰈀 {ifname}:{ipaddr}/{cidr}";
              format-disconnected = " Disconnected";
              tooltip-format = "{ifname}:{ipaddr}";
            };

            tray = {
              icon-size = 18;
            };

            "hyprland/submap" = {
              always_on = true;
              format = "⚠️ {} ";
            };

            "hyprland/window" = {
              format = "{class}";
              separate-outputs = true;
              rewrite = {
                "(.*)KeePassXC" = "keepassxc";
              };
            };

            "hyprland/workspaces" = {
              format = "{icon}:{windows} ";
              persistent-workspaces = {
                "1" = "*";
                "2" = "*";
                "3" = "*";
                "8" = "*";
                "9" = "*";
                "10" = "*";
              };
              window-rewrite = {
                "class<.*KeePassXC>" = "󱚨 ";
                "class<discord>" = " ";
                "class<firefox>" = " ";
                "class<kitty>" = " ";
              };
              window-rewrite-default = "󰣆 ";
            };
          }
        ];
      };
    };
  }
