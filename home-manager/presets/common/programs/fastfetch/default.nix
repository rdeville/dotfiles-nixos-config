{
  userCfg,
  pkgs,
  mkLib,
  ...
}: {
  programs = {
    fastfetch = {
      enable = true;
      package = mkLib.nixGLWrap pkgs.fastfetch userCfg;
      settings = {
        "$schema" = "https://github.com/fastfetch-cli/fastfetch/raw/main/doc/json_schema.json";
        general = {
          multithreading = true;
          thread = true;
        };
        logo = {
          source = "./logo.txt";
          color = {
            "1" = "bright_red";
            "2" = "red";
            "3" = "light_red";
          };
        };
        display = {
          color = {
            keys = "red";
            output = "white";
            title = "yellow";
          };
          # // "keyWidth"= 8;
          separator = "\u001b[36m   ";
          binaryPrefix = "iec";
          bar = {
            border = false;
            width = 10;
            charTotal = "\u001b[30m■";
            charElapsed = "■";
          };
          percent = {
            ndigits = 2;
            type = 3;
          };
        };
        modules = [
          {
            type = "custom";
            format = "\u001b[31m┌─── \u001b[33mHardware Information \u001b[31m──────────────────────────────────";
          }
          {
            type = "host";
            key = "│ 󰌢 ";
            format = "{2} {5}";
          }
          {
            type = "cpu";
            key = "│ 󰻠 ";
          }
          {
            type = "cpuusage";
            key = "│  ";
          }
          {
            type = "gpu";
            key = "│ 󰍛 ";
          }
          {
            type = "memory";
            key = "│ 󰑭 ";
          }
          {
            type = "disk";
            key = "│  ";
          }
          {
            type = "battery";
            key = "│  ";
            # // "format"= "{1}-{2}-{3}-{4}-{5}-{6}-{7}-{8}-{9}-{10}-{11}-{12}";
            # // Will be availabled in later version
            # // "percent"= {
            # //   "display"= "bar";
            # // }
          }
          {
            type = "sound";
            key = "│  ";
            soundType = "all";
            # // Will be availabled in later version
            # // "percent"= {
            # //   "display"= "bar";
            # // }
          }
          {
            type = "custom";
            format = "\u001b[31m├─── \u001b[33mOS Information \u001b[31m────────────────────────────────────────";
          }
          {
            type = "kernel";
            key = "│  ";
          }
          {
            type = "os";
            key = "│  ";
          }
          {
            type = "uptime";
            key = "│ 󰅐 ";
            format = "{?1}{1} day(s) {?}{?2}{2} hours and {?}{3} minutes";
          }
          {
            type = "packages";
            key = "│ 󰏖 ";
            # // "format"= "TTL : {1} {?2} {2}{?} (pacman){?3}[{3}]{?} {4} (dpkg), {5} (rpm), {6} (emerge), \n{7} (eopkg), {8} (xbps), {9} (nix-system), {10} (nix-user), \n{11} (nix-default), {12} (apk), {13} (pkg), {14} (flatpak-system), {15} (flatpack-user), \n{16} (snap), {17} (brew), {18} (brew-cask), {19} (MacPorts), \n{20} (scoop), {21} (choco), {22} (pkgtool), {23} (paludis), {24} (winget), \n{25} (opkg), {26} (am), {27} (sorcery), {28} (lpkg), {29} (lpkgbuild)";
          }
          {
            type = "opengl";
            key = "│  ";
          }
          {
            type = "users";
            key = "│  ";
          }
          {
            type = "shell";
            key = "│  ";
          }
          {
            type = "terminal";
            key = "│  ";
          }
          {
            type = "locale";
            key = "│  ";
          }
          {
            type = "custom";
            format = "\u001b[31m├─── \u001b[33mNetwork Information \u001b[31m───────────────────────────────────";
          }
          {
            type = "localip";
            key = "│ 󰩠 ";
            showAllIps = true;
            compact = true;
          }
          {
            type = "publicip";
            format = "{1}";
            key = "│ 󱫋 ";
          }
          {
            type = "wifi";
            key = "│ 󰀂 ";
            format = "{4}";
          }
          {
            type = "custom";
            format = "\u001b[31m├─── \u001b[33mGraphical Information \u001b[31m─────────────────────────────────";
          }
          {
            type = "lm";
            key = "│ 󰧨 ";
          }
          {
            type = "de";
            key = "│  ";
          }
          {
            type = "wm";
            key = "│  ";
          }
          {
            type = "theme";
            key = "│  ";
          }
          {
            type = "icons";
            key = "│  ";
          }
          {
            type = "cursor";
            key = "│  ";
          }
          {
            type = "weather";
            key = "│ 󰼲 ";
            location = "Lyon";
          }
          {
            type = "custom";
            format = "\u001b[31m└───────────────────────────────────────────────────────────";
          }
          {
            type = "colors";
            paddingLeft = 5;
            block = {
              width = 5;
            };
          }
        ];
      };
    };
  };
}
