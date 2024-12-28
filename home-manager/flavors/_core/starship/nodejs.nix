{
  lib,
  colors,
  sep,
  ...
}: let
  bg = colors.material-all.yellow_300;
  fg = colors.material-all.grey_900;
  red = colors.material-all.red_300;
  # emphasis
  em = "bold";
in {
  # Disables the module.
  disabled = false;

  # A format string representing the symbol of Node.js.
  symbol = "󰎙 ";

  # The version format. Available vars are raw, major, minor, & patch
  version_format = "v\${raw}";
  # Which extensions should trigger this module.
  detect_extensions = ["js" "mjs" "cjs" "ts" "mts" "cts"];
  # Which filenames should trigger this module.
  detect_files = ["package.json" ".node-version"];
  # Which folders should trigger this module.
  detect_folders = ["node_modules"];

  # The style for the module when an engines property in package.json does not
  # match the Node.js version.
  not_capable_style = "bg:${bg} fg:${red}";
  # The style of the module.
  style = "bg:${bg} fg:${fg}";

  # The format for the module.
  format = lib.concatStrings [
    "[${sep.left}](fg:${sep.clr} bg:${bg})"
    "[ $symbol$version]($style)"
    "[${sep.left}](bg:${sep.clr} fg:${bg})"
  ];
}
