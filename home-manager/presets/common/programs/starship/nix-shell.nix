{
  lib,
  colors,
  sep,
  folder,
  ...
}: let
  fg = colors.material-all.blue_400;
  bg = folder.bg; # colors.material-all.grey_900;
  red = colors.material-all.red_300;
  green = colors.material-all.green_300;
  orange = colors.material-all.orange_300;
  # emphasis
  em = "bold";
in {
  # Disables the module.
  disabled = false;

  # A format string representing the symbol of nix-shell.
  symbol = " ";
  # A format string shown when the shell is impure.
  impure_msg = "[ ](${em} bg:${bg} fg:${red})";
  # A format string shown when the shell is pure.
  pure_msg = "[ ](${em} bg:${bg} fg:${green})";
  # A format string shown when it is unknown if the shell is pure/impure.
  unknown_msg = "[ ](${em} bg:${bg} fg:${orange})";
  # Attempts to detect new nix shell-style shells with a heuristic.
  heuristic = false;

  # The style of the module.
  style = "bg:${bg} fg:${fg}";

  # The format for the module.
  format = lib.concatStrings [
    "[ $symbol$state]($style)"
  ];
}
