{
  lib,
  userCfg,
  colors,
  sep,
  ...
}: let
  bg = colors.material-all.green_300;
  fg = colors.material-all.grey_900;
  fg_root = colors.material-all.red_500;
  # emphasis
  em = "bold";
in {
  # Disables the username module.
  disabled = false;

  # Always shows the username module.
  show_always = true;
  # Translate system usernames to something else
  aliases = {
    "${userCfg.username}" = "me";
    "root" = "GOD";
  };

  # The style used when the user is root/admin.
  style_root = "${em} bg:${bg} fg:${fg_root}";
  # The style used for non-root users.
  style_user = "bg:${bg} fg:${fg}";

  # The format for the module.
  format = lib.concatStrings [
    "[${sep.right}](bg:${colors.material-all.black} fg:${bg})"
    "[  $user ]($style)"
    "[${sep.right}](fg:${sep.clr} bg:${bg})"
  ];
}
