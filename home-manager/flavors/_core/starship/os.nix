{
  lib,
  colors,
  sep,
  ...
}: let
  fg = colors.material-all.grey_100;
  bg = colors.material-all.grey_700;
in {
  # Disables the username module.
  disabled = false;

  # A table that maps each operating system to its symbol.
  symbols = {
    Arch = "[ ](bg:${bg} fg:${colors.material-all.blue_400})";
    Debian = "[ ](bg:${bg} fg:${colors.material-all.red_400})";
    Linux = "[ ](bg:${bg} fg:${colors.material-all.yellow_400})";
    Macos = "[ ](bg:${bg} fg:${colors.material-all.grey_100})";
    NixOS = "[ ](bg:${bg} fg:${colors.material-all.blue_400})";
    Raspbian = "[ ](bg:${bg} fg:${colors.material-all.pink_400})";
    Ubuntu = "[ ](bg:${bg} fg:${colors.material-all.orange_400})";
    Unknown = "❓";
  };

  # The style used for the module
  style = "bg:${bg} fg:${fg}";

  #The format for the module.
  format = lib.concatStrings [
    "[${sep.right}](bg:${sep.clr} fg:${bg})"
    "[ $symbol ]($style)"
    "[${sep.right}](bg:${bg} fg:${sep.clr})"
  ];
}
