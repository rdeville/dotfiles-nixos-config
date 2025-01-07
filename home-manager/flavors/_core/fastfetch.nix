{
  config,
  pkgs,
  lib,
  ...
}: let
  name = builtins.baseNameOf ./.;
  cfg = config.hm.flavors.${name};

  modules = [
    {
      type = "custom";
      format = ''{#31}┌─── {#33}Hardware Information {#31}──────────────────────────────────'';
    }
    {
      type = "host";
      key = "│ {#32}󰌢 ";
      format = "{2} {5}";
    }
    {
      type = "cpu";
      key = "│ {#32}󰻠 ";
    }
    {
      type = "cpuusage";
      key = "│ {#32} ";
    }
    {
      type = "gpu";
      key = "│ {#32}󰍛 ";
    }
    {
      type = "memory";
      key = "│ {#32}󰑭 ";
    }
    {
      type = "disk";
      key = "│ {#32} ";
    }
    {
      type = "battery";
      key = "│ {#32} ";
      # // "format"= "{1}-{2}-{3}-{4}-{5}-{6}-{7}-{8}-{9}-{10}-{11}-{12}";
      # // Will be availabled in later version
      # // "percent"= {
      # //   "display"= "bar";
      # // }
    }
    {
      type = "sound";
      key = "│ {#32} ";
      soundType = "all";
      # // Will be availabled in later version
      # // "percent"= {
      # //   "display"= "bar";
      # // }
    }
    {
      type = "custom";
      format = "{#31}├─── {#33}OS Information {#31}────────────────────────────────────────";
    }
    {
      type = "kernel";
      key = "│ {#32} ";
    }
    {
      type = "os";
      key = "│ {#32} ";
    }
    {
      type = "uptime";
      key = "│ {#32}󰅐 ";
      format = "{?1}{1} day(s) {?}{?2}{2} hours and {?}{3} minutes";
    }
    {
      type = "packages";
      key = "│ {#32}󰏖 ";
      # // "format"= "TTL : {1} {?2} {2}{?} (pacman){?3}[{3}]{?} {4} (dpkg), {5} (rpm), {6} (emerge), \n{7} (eopkg), {8} (xbps), {9} (nix-system), {10} (nix-user), \n{11} (nix-default), {12} (apk), {13} (pkg), {14} (flatpak-system), {15} (flatpack-user), \n{16} (snap), {17} (brew), {18} (brew-cask), {19} (MacPorts), \n{20} (scoop), {21} (choco), {22} (pkgtool), {23} (paludis), {24} (winget), \n{25} (opkg), {26} (am), {27} (sorcery), {28} (lpkg), {29} (lpkgbuild)";
    }
    {
      type = "opengl";
      key = "│ {#32} ";
    }
    {
      type = "users";
      key = "│ {#32} ";
    }
    {
      type = "shell";
      key = "│ {#32} ";
    }
    {
      type = "terminal";
      key = "│ {#32} ";
    }
    {
      type = "locale";
      key = "│ {#32} ";
    }
    {
      type = "custom";
      format = "{#31}├─── {#33}Network Information {#31}───────────────────────────────────";
    }
    {
      type = "localip";
      key = "│ {#32}󰩠 ";
      showAllIps = true;
      compact = true;
    }
    {
      type = "publicip";
      format = "{1}";
      key = "│ {#32}󱫋 ";
    }
    {
      type = "wifi";
      key = "│ {#32}󰀂 ";
      format = "{4}";
    }
    {
      type = "custom";
      format = "{#31}├─── {#33}Graphical Information {#31}─────────────────────────────────";
    }
    {
      type = "lm";
      key = "│ {#32}󰧨 ";
    }
    {
      type = "de";
      key = "│ {#32} ";
    }
    {
      type = "wm";
      key = "│ {#32} ";
    }
    {
      type = "theme";
      key = "│ {#32} ";
    }
    {
      type = "icons";
      key = "│ {#32} ";
    }
    {
      type = "cursor";
      key = "│ {#32} ";
    }
    {
      type = "custom";
      format = "{#31}└───────────────────────────────────────────────────────────";
    }
    {
      type = "colors";
      paddingLeft = 5;
      block = {
        width = 5;
      };
    }
  ];
in {
  options = {
    hm = {
      flavors = {
        ${name} = {
          fastfetch = {
            modules = lib.mkOption {
              type = lib.types.listOf lib.types.attrs;
              description = "Module configuration to setup for fastfetch.";
              default = modules;
            };

            logo = {
              source = lib.mkOption {
                type = lib.types.nullOr lib.types.path;
                default = null;
                description = "Path to the logo to use in fastfetch";
              };

              color = lib.mkOption {
                type = lib.types.attrsOf lib.types.str;
                default = {};
                description = "Path to the logo to use in fastfetch";
              };
            };
          };
        };
      };
    };
  };

  config = lib.mkIf cfg.enable {
    programs = {
      fastfetch = {
        enable = true;
        package = pkgs.fastfetch;
        settings = {
          "$schema" = "https://github.com/fastfetch-cli/fastfetch/raw/main/doc/json_schema.json";
          inherit (cfg.fastfetch) modules logo;
          general = {
            multithreading = true;
            thread = true;
          };
          display = {
            color = {
              keys = "red";
              output = "white";
              title = "yellow";
            };
            # // "keyWidth"= 8;
            separator = "   ";
            size = {
              binaryPrefix = "iec";
            };
            bar = {
              borderLeft = "";
              borderRight = "";
              width = 10;
              charTotal = "□";
              charElapsed = "■";
            };
            percent = {
              ndigits = 2;
              type = 3;
            };
          };
        };
      };
    };
  };
}
