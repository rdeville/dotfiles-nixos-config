{
  lib,
  colors,
  sep,
  git,
  ...
}: let
  bg = git.bg;
  fg_commit = colors.material-all.blue_500;
  fg_tag = colors.material-all.deep_purple_300;
  black = colors.material-all.black;
  # emphasis
  em = "bold";
in {
  # Enable the module
  disabled = false;

  # The length of the displayed git commit hash.
  commit_hash_length = 7;
  # Only show git commit hash when in detached HEAD state
  only_detached = false;
  # Disables showing tag info in git_commit module.
  tag_disabled = false;
  # How many commits to consider for tag display.
  # The default only allows exact matches.
  tag_max_candidates = 0;
  # Tag symbol prefixing the info shown
  tag_symbol = " 🔖 ";

  # The style for the module.
  style = "bg:${bg}";
  # The format for the module.
  format = lib.concatStrings [
    "[ $hash](bg:${bg} fg:${fg_commit})"
    "[$tag](${em} bg:${bg} fg:${fg_tag})"
  ];
}
