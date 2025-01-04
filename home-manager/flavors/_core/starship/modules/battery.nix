{
  config,
  lib,
  ...
}: let
  name = "battery";
  cfg = mkLib.mkGetSarshipModuleConfig name;
  mkLib = import ../lib.nix {inherit config;};

  sep = mkLib.sep.${cfg.position};
  bg = mkLib.colors.grey_900;
  fg = mkLib.colors.red_500;
in {
  options = mkLib.mkSetStarshipModuleOptions name {
    disabled = lib.mkEnableOption "Disable starship ${name} module.";

    position = lib.mkOption {
      type = lib.types.str;
      description = "Position of the module (right or left)";
      default = "right";
    };

    full_symbol = lib.mkOption {
      type = lib.types.str;
      description = "The symbol shown when the battery is full.";
      default = " 󱊣";
    };

    unknown_symbol = lib.mkOption {
      type = lib.types.str;
      description = "The symbol shown when the battery state is unknown.";
      default = " 󰂑";
    };

    empty_symbol = lib.mkOption {
      type = lib.types.str;
      description = "The symbol shown when the battery state is empty.";
      default = " 󰂎";
    };

    format = lib.mkOption {
      type = lib.types.str;
      description = "The format for the module.";
      default = lib.concatStrings [
        (sep bg)
        "[ $symbol $percentage ]($style)"
      ];
    };

    display = lib.mkOption {
      type = lib.types.listOf (lib.types.submodule {
        options = {
          threshold = lib.mkOption {
            type = lib.types.int;
            default = 25;
          };

          style = lib.mkOption {
            type = lib.types.str;
            default = "bg:${bg} fg:${fg} bold";
          };

          charging_symbol = lib.mkOption {
            type = lib.types.str;
            default = "󱐥󰂎";
          };

          discharging_symbol = lib.mkOption {
            type = lib.types.str;
            default = " 󰂎";
          };
        };
      });
      default = [{}];
    };
  };

  config = {
    programs = {
      starship = {
        settings = {
          ${name} = {
            inherit
              (cfg)
              disabled
              full_symbol
              unknown_symbol
              empty_symbol
              display
              format
              ;
          };
        };
      };
    };
  };
}
