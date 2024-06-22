{
  lib,
  colors,
  sep,
  git,
  ...
}: let
  bg = git.bg;
  fg_conflict = colors.material-all.red_500;
  fg_ahead = colors.material-all.green_500;
  fg_behind = colors.material-all.red_500;
  fg_diverged = colors.material-all.red_500;
  fg_ok = colors.material-all.green_500;
  fg_untracked = colors.material-all.yellow_500;
  fg_stashed = colors.material-all.pink_500;
  fg_modified = colors.material-all.orange_500;
  fg_staged = colors.material-all.green_500;
  fg_renamed = colors.material-all.lime_500;
  fg_deleted = colors.material-all.red_500;
  fg_type_changed = colors.material-all.cyan_500;
  black = colors.material-all.black;
  # emphasis
  em = "bold";
in {
  # Enable the module
  disabled = false;

  # This branch has merge conflicts.
  conflicted = "[  $count](bg:${bg} fg:${fg_conflict})";
  # The format of ahead
  ahead = "[ $count](bg:${bg} fg:${fg_ahead})";
  # The format of behind
  behind = "[ $count](bg:${bg} fg:${fg_behind})";
  # The format of diverged
  diverged = lib.concatStrings [
    "[ "
    "[ \${behind_count}](bg:${bg} fg:${fg_behind})"
    "[ \${ahead_count}](bg:${bg} fg:${fg_ahead})"
    "](bg:${bg} fg:${fg_diverged})"
  ];
  # The format of up_to_date
  up_to_date = "[ ](bg:${bg} fg:${fg_ok})";
  # The format of stashed
  stashed = "[  $count](bg:${bg} fg:${fg_stashed})";
  # The format of untracked
  untracked = "[  $count](bg:${bg} fg:${fg_untracked})";
  # The format of modified
  modified = "[  $count](bg:${bg} fg:${fg_modified})";
  # The format of staged
  staged = "[  $count](bg:${bg} fg:${fg_staged})";
  # The format of renamed
  renamed = "[  $count](bg:${bg} fg:${fg_renamed})";
  # The format of deleted
  deleted = "[  $count](bg:${bg} fg:${fg_deleted})";
  # The format of typechange
  typechanged = "[  $count](bg:${bg} fg:${fg_type_changed})";
  # Ignore changes to submodules.
  ignore_submodules = true;

  # The style for the module.
  style = "bg:${bg}";
  # The default format for git_status
  # The format for the module.
  format = lib.concatStrings [
    "[$ahead_behind$all_status]($style)"
  ];
}
