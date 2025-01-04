{
  config,
  lib,
  ...
}: let
  name = "character";
  cfg = mkLib.mkGetSarshipModuleConfig name;
  mkLib = import ../lib.nix {inherit config;};

  sep = mkLib.sep.${cfg.position};
  fg = mkLib.colors.grey_100;
  bg_green = mkLib.colors.green_500;
  bg_yellow = mkLib.colors.yellow_500;
  bg_orange = mkLib.colors.orange_500;
  bg_red = mkLib.colors.red_500;
  bg_purple = mkLib.colors.purple_500;
  bg_blue = mkLib.colors.light_blue_500;
  format = symbol: bg:
    lib.concatStrings [
      (sep bg)
      "[ ${symbol} ](fg:${fg} bg:${bg})"
      (sep "black")
    ];
in {
  options = mkLib.mkSetStarshipModuleOptions name {
    disabled = lib.mkEnableOption "Disable starship ${name} module.";

    position = lib.mkOption {
      type = lib.types.str;
      description = "Position of the module (right or left)";
      default = "left";
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
              ;
            # The format string used before the text input if the previous command succeeded.
            success_symbol = format "I" bg_green;
            # The format string used before the text input if the previous command failed.
            error_symbol = format "I" bg_red;
            # The format string used before the text input if the shell is in vim normal mode.
            vimcmd_symbol = format "C" bg_blue;
            # The format string used before the text input if the shell is in vim replace_one mode.
            vimcmd_replace_one_symbol = format "R" bg_yellow;
            # The format string used before the text input if the shell is in vim replace mode.
            vimcmd_replace_symbol = format "R" bg_orange;
            # The format string used before the text input if the shell is in vim visual mode.
            vimcmd_visual_symbol = format "V" bg_purple;
          };
        };
      };
    };
  };
}
