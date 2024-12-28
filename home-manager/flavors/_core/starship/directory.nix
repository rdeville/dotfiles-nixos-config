{
  lib,
  colors,
  sep,
  folder,
  ...
}: let
  bg = folder.bg; # colors.material-all.grey_900;
  fg = colors.material-all.grey_100;
  git_fg = colors.material-all.red_300;
  ro_fg = colors.material-all.red_500;
in {
  # Enable the module
  disabled = false;

  # The number of parent folders that the current directory should be truncated to.
  truncation_length = 3;
  # Whether or not to truncate to the root of the git repo that youre currently in.
  truncate_to_repo = false;
  # The symbol indicating current directory is read only.
  read_only = " ";
  # The symbol to prefix to truncated paths. eg: …/
  truncation_symbol = "…/";
  # The symbol indicating home directory.
  home_symbol = "~";
  # Use the OS specific path separator instead of always using / (e.g. \ on Windows)
  use_os_path_sep = true;

  # The style for the read only symbol.
  read_only_style = "bg:${bg} fg:${ro_fg}";
  # The style for the root of the git repo. The default value is equivalent to style.
  repo_root_style = "bg:${bg} fg:${git_fg}";
  # The format of a git repo when before_repo_root_style and repo_root_style is defined.
  repo_root_format = lib.concatStrings [
    "[  ]($style)"
    "[ $read_only]($read_only_style)"
    "[$before_root_path]($before_repo_root_style)"
    "[$repo_root]($repo_root_style)"
    "[$path]($style)"
  ];

  # The style for the module.
  style = "bg:${bg} fg:${fg}";
  # The format for the module.
  format = lib.concatStrings [
    "[  ]($style)"
    "[ $read_only]($read_only_style)"
    "[$path]($style)"
  ];
}
