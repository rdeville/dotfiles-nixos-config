{
  lib,
  colors,
  sep,
  ...
}: let
  bg = colors.material-all.blue_300;
  fg = colors.material-all.grey_100;
in {
  # Enable the module
  disabled = false;

  # The format of a git repo when before_repo_root_style and repo_root_style is defined.
  symbol = "⬢ ";

  # The style for the module.
  style = "bg:${bg} fg:${fg}";
  # The format for the module.
  format = lib.concatStrings [
    "[${sep.right}](bg:${sep.clr} fg:${bg})"
    "[ $symbol$name ]($style)"
    "[${sep.right}](fg:${sep.clr} bg:${bg})"
  ];
}
