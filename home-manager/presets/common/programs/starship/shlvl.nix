{
  lib,
  colors,
  sep,
  ...
}: let
  bg = colors.material-all.grey_800;
  fg = colors.material-all.grey_100;
  # emphasis
  em = "bold";
in {
  # Disables the module.
  disabled = false;

  # The symbol used to represent the SHLVL.
  symbol = "";
  # Display threshold.
  threshold = 2;
  # Causes symbol to be repeated by the current SHLVL amount.
  repeat = false;
  # Decrements number of times symbol is repeated by the offset value
  repeat_offset = 0;

  # The style of the module.
  style = "${em} bg:${bg} fg:${fg}";

  # The format for the module.
  format = lib.concatStrings [
    "[ $symbol$shlvl]($style)"
  ];
}
