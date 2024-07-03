{
  lib,
  colors,
  sep,
  stdin,
  ...
}: let
  black = colors.material-all.black;
  fg = colors.material-all.grey_100;
  bg_green = colors.material-all.green_500;
  bg_yellow = colors.material-all.yellow_500;
  bg_orange = colors.material-all.orange_500;
  bg_red = colors.material-all.red_500;
  bg_purple = colors.material-all.purple_500;
  bg_blue = colors.material-all.light_blue_500;
  # emphasis
  em = "bold";
  format = symbol: bg:
    lib.concatStrings [
      "[${sep.left}](fg:${stdin.bg} bg:${bg})"
      "[ ${symbol} ](${em} fg:${fg} bg:${bg})"
      "[${sep.left}](bg:${black} fg:${bg})"
    ];
in {
  # Disables the module.
  disabled = false;

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
}
