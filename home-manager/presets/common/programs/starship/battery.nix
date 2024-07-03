{
  lib,
  colors,
  sep,
  ...
}: let
  black = colors.material-all.black;
  bg = colors.material-all.grey_900;
  fg_25 = colors.material-all.red_500;
  fg_50 = colors.material-all.orange_500;
  fg_75 = colors.material-all.yellow_500;
  fg_100 = colors.material-all.green_500;
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
    {
      threshold = 50;
      style = "${em} bg:${bg} ${fg_50}";
      charging_symbol = "󱐥󱊡";
      discharging_symbol = " 󱊡";
    }
    {
      threshold = 75;
      style = "${em} bg:${bg} ${fg_75}";
      charging_symbol = "󱐥󱊢";
      discharging_symbol = " 󱊢";
    }
    {
      threshold = 100;
      style = "${em} bg:${bg} fg:${fg_100}";
      charging_symbol = "󱐥󱊣";
      discharging_symbol = " 󱊣";
    }
  ];
  # The format for the module.
  format = lib.concatStrings [
    "[${sep.right}](fg:${bg} bg:${sep.clr})"
    "[ $symbol $percentage ]($style)"
    "[${sep.right}](fg:${sep.clr} bg:${bg})"
  ];
}
