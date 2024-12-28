{
  lib,
  colors,
  sep,
  ...
}: let
  bg = colors.material-all.deep_purple_800;
  fg = colors.material-all.grey_100;
in {
  # Disables the username module.
  disabled = false;

  # A format string shown before the terraform workspace.
  symbol = "󱁢 ";
  # The version format. Available vars are raw, major, minor, & patch
  version_format = "v\${raw}";
  # Which extensions should trigger this module.
  detect_extensions = ["tf" "tfplan" "tfstate" "hcl"];
  # Which filenames should trigger this module.
  detect_files = [];
  # Which folders should trigger this module.
  detect_folders = [".terraform"];

  # The style used for the module
  style = "bg:${bg} fg:${fg}";

  #The format for the module.
  format = lib.concatStrings [
    "[${sep.right}](bg:${sep.clr} fg:${bg})"
    "[ $symbol$version:$workspace ]($style)"
    "[${sep.right}](bg:${bg} fg:${sep.clr})"
  ];
}
