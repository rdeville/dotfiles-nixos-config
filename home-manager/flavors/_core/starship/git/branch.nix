{
  lib,
  colors,
  sep,
  git,
  ...
}: let
  bg = git.bg;
  fg = colors.material-all.light_blue_300;
  fg_remote = colors.material-all.light_blue_800;
  black = colors.material-all.black;
in {
  # Enable the module
  disabled = false;

  # A format string representing the symbol of git branch.
  symbol = " ";

  # Shows the remote tracking branch name, even if it is equal to the local
  # branch name.
  always_show_remote = false;
  # Truncates a git branch to N graphemes.
  # truncation_length = 2^63 - 1;
  # The symbol used to indicate a branch name was truncated.
  truncation_symbol = "…";
  # Only show the branch name when not in a detached HEAD state.
  only_attached = false;
  # A list of names to avoid displaying. Useful for 'master' or 'main'.
  ignore_branches = [];

  # The style for the module.
  style = "bg:${bg}";
  # The format for the module.
  format = lib.concatStrings [
    "[ $symbol](bg:${bg} fg:${fg})"
    "[$branch](bg:${bg} fg:${fg})"
    "[(:$remote_branch)](bg:${bg} fg:${fg_remote})"
  ];
}
