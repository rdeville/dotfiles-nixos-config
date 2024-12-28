{
  lib,
  colors,
  sep,
  ...
}: let
  bg = colors.material-all.blue_800;
  fg = colors.material-all.grey_100;
  black = colors.material-all.black;
in {
  # Enable the module
  disabled = false;

  # The symbol used before displaying the current GCP profile.
  symbol = "󱇶 ";

  # Table of region aliases to display in addition to the GCP name.
  region_aliases = {};
  # Table of project aliases to display in addition to the GCP name.
  project_aliases = {};
  # Which environmental variables should trigger this module
  detect_env_vars = [];

  # The style for the module.
  style = "bg:${bg} fg:${fg}";
  # The format for the module.
  format = lib.concatStrings [
    "[${sep.right}](bg:${sep.clr} fg:${bg})"
    "[ $symbol$project$region ]($style)"
    "[${sep.right}](bg:${bg} fg:${sep.clr})"
  ];
}
