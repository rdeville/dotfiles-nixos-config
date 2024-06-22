{
  lib,
  colors,
  sep,
  ...
}: let
  fg = colors.material-all.grey_900;
  bg = colors.material-all.yellow_300;
in {
  # Disables the username module.
  disabled = false;

  # Only show hostname when connected to an SSH session.
  ssh_only = false;
  # A format string representing the symbol when connected to SSH session.
  ssh_symbol = "󰢹 ";
  # String that the hostname is cut off at, after the first match. '.' will stop after the first dot. '' will disable any truncation.
  trim_at = ".";

  # The style used for the module
  style = "bg:${bg} fg:${fg}";

  #The format for the module.
  format = lib.concatStrings [
    "[${sep.right}](bg:${sep.clr} fg:${bg})"
    "[ 󰇄 $ssh_symbol$hostname ]($style)"
    "[${sep.right}](fg:${sep.clr} bg:${bg})"
  ];
}
