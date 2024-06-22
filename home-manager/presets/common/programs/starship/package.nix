{
  lib,
  colors,
  sep,
  ...
}: let
  bg = colors.material-all.deep_orange_300;
  fg = colors.material-all.grey_900;
in {
  # Enable the module
  disabled = false;

  # The symbol used before displaying the version the package.
  symbol = " ";

  # The version format. Available vars are raw, major, minor, & patch
  version_format = "v\${raw}";
  # Enable displaying version for packages marked as private.
  display_private = false;

  style = "bg:${bg} fg:${fg}";
  # The format for the module.
  format = lib.concatStrings [
    "[${sep.left}](bg:${bg} fg:${sep.clr})"
    "[ $symbol$version ]($style)"
    "[${sep.left}](fg:${bg} bg:${sep.clr})"
  ];
}
