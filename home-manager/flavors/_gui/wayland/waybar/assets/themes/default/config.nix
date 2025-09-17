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
            height = 24;
            spacing = 0;

            modules-left = [
              "hyprland/workspaces"
              "hyprland/mode"
              "hyprland/window"
            ];
            modules-right = [
              "battery"
              "network#speed"
              "network#ip"
              "memory"
              "cpu"
              "tray"
              "clock"
            ];

            # Modules
            # -------------------------------------------------------------------
            battery = {
              interval = 60;
              states = {
                warning = 30;
                critical = 15;
              };
              format = "󱐥{icon} {capacity}%";
              format-charging = "󱐥{icon} {capacity}%({time})";
              format-discharging = " {icon} {capacity}%({time})";
              format-time = "{H}:{M}";
              format-icons = ["󰂎" "󱊡" "󱊢" "󱊣"];
              tooltip = false;
            };

            clock = {
              format = " {:%a %e %b | %H:%M:%S}";
              tooltip = false;
            };

            cpu = {
              interval = 5;
              format = " {usage}%({load:0.1f})";
              states = {
                warning = 70;
                critical = 90;
              };
            };

            memory = {
              interval = 5;
              format = " {used:0.1f}Go({}%)";
              states = {
                warning = 70;
                critical = 90;
              };
            };

            "network#ip" = {
              interval = 5;
              format-wifi = "  {ifname}:{ipaddr} ({essid} {signalStrength}%)";
              format-ethernet = "  {ifname}: {ipaddr}/{cidr}";
              format-disconnected = "  Disconnected";
            };

            "network#speed" = {
              interval = 5;
              format = " 󰞒 {bandwidthDownOctets}   {bandwidthUpOctets} 󰞕 ";
            };

            "hyprland/submap" = {
              format = "⚠️ {}";
              tooltip = false;
            };

            "hyprland/window" = {
              format = "{class}";
              max-length = 120;
              rewrite = {
                firefox = "Firefox";
                kitty = "Kitty";
                org.keepassxc.KeePassXC = "KeePassXC";
                thunderbird = "Thunderbird";
              };
              icon-size = 18;
              icon = true;
            };

            "hyprland/workspaces" = {
              all-outputs = true;
              disable-scroll = true;
              format = "{name}:{icon}";
              format-icons = {
                "1" = " ";
                "2" = " ";
                "3" = " ";
                "8" = "󰇮 ";
                "9" = "󰚚 ";
                "10" = " ";
                urgent = " ";
                focused = " ";
                default = " ";
              };
            };

            tray = {
              icon-size = 18;
            };
          }
        ];
      };
    };
  }
