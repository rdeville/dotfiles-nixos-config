{
  lib,
  colors,
  sep,
  git,
  ...
}: let
  bg = git.bg;
  fg_add = colors.material-all.green_500;
  fg_del = colors.material-all.red_500;
  fg = colors.material-all.grey_500;
  black = colors.material-all.black;
  # emphasis
  em = "bold";
in {
  # Enable the module
  disabled = false;

  # The style for the added count.
  added_style = "fg:${fg_add} bg:${bg}";
  # The style for the deleted count.
  deleted_style = "fg:${fg_del} bg:${bg}";
  # Render status only for changed items.
  only_nonzero_diffs = true;
  # Ignore changes to submodules
  ignore_submodules = true;

  # The format for the module.
  format = lib.concatStrings [
    "("
    "([+$added]($added_style))"
    "("
    "[/](bg:${bg} fg:${fg})"
    "[-$deleted]($deleted_style)"
    ")"
    "[ ](bg:${bg} fg:${fg})"
    ")"
  ];
}
