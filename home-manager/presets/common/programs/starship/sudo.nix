{
  lib,
  colors,
  sep,
  ...
}: let
  fg = colors.material-all.red_300;
  bg = colors.material-all.grey_800;
  # emphasis
  em = "bold";
in {
  # Disables the module.
  disabled = false;

  # The symbol displayed when credentials are cached
  symbol = " ";

  # The style of the module.
  style = "${em} bg:${bg} fg:${fg}";

  # The format for the module.
  format = lib.concatStrings [
    "[ $symbol]($style)"
  ];
}
