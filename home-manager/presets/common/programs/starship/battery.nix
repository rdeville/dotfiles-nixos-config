{
  lib,
  colors,
  sep,
  ...
}: let
  bg = colors.material-all.grey_900;
  fg_25 = colors.material-all.red_500;
  # emphasis
  em = "bold";
in {
  # Enable the module
  disabled = false;
  # The symbol shown when the battery is full.
  full_symbol = " 󱊣";
  # The symbol shown when the battery state is unknown.
  unknown_symbol = " 󰂑";
  # The symbol shown when the battery state is empty.
  empty_symbol = " 󰂎";
  # Display threshold and style for the module.
  display = [
    {
      threshold = 25;
      style = "${em} bg:${bg} ${fg_25}";
      charging_symbol = "󱐥󰂎";
      discharging_symbol = " 󰂎";
    }
  ];
  # The format for the module.
  format = lib.concatStrings [
    "[${sep.right}](fg:${bg} bg:${sep.clr})"
    "[ $symbol $percentage ]($style)"
    "[${sep.right}](fg:${sep.clr} bg:${bg})"
  ];
}
