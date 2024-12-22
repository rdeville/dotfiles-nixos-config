{
  lib,
  colors,
  sep,
  ...
}: let
  bg = colors.material-all.light_green_600;
  fg = colors.material-all.grey_900;
  # emphasis
  em = "bold";
in {
  # Disables the module.
  disabled = false;

  # The symbol used before displaying the variable value.
  symbol = "󰌋 ";
  # The environment variable to be displayed.
  variable = "KEEPASS_NAME";
  # The default value to be displayed when the selected variable is not defined.
  default = "";
  # The description of the module that is shown when running starship explain.
  description = "Show the name of KEEPASS_NAME";

  # The style of the module.
  style = "bg:${bg} fg:${fg}";

  # The format for the module.
  format = lib.concatStrings [
    "("
    "[${sep.right}](bg:${sep.clr} fg:${bg})"
    "[ $symbol$env_value ]($style)"
    "[${sep.right}](fg:${sep.clr} bg:${bg})"
    ")"
  ];
}
