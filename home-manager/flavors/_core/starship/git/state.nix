{
  lib,
  colors,
  sep,
  git,
  ...
}: let
  bg = colors.material-all.red_500;
  fg = colors.material-all.grey_900;
  black = colors.material-all.black;
  # emphasis
  em = "bold";
in {
  # Enable the module
  disabled = false;

  # A format string displayed when a rebase is in progress.
  rebase = "REBASING";
  # A format string displayed when a merge is in progress.
  merge = "MERGING";
  # A format string displayed when a revert is in progress.
  revert = "REVERTING";
  # A format string displayed when a cherry-pick is in progress.
  cherry_pick = "CHERRY-PICKING";
  # A format string displayed when a bisect is in progress.
  bisect = "BISECTING";
  # A format string displayed when an apply-mailbox (git am) is in progress.
  am = "AM";
  # A format string displayed when an ambiguous apply-mailbox or rebase is in progress.
  am_or_rebase = "AM/REBASE";

  # The style for the module.
  style = "bg:${bg}";
  # The format for the module.
  format = lib.concatStrings [
    "[${sep.left}](bg:${bg} fg:${git.bg})"
    "[ $state ($progress_current/$progress_total) ]($style)"
    "[${sep.left}](fg:${bg} bg:${git.bg})"
  ];
}
