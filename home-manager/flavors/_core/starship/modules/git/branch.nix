{
  config,
  lib,
  ...
}: let
  name = "git_branch";
  cfg = mkLib.mkGetSarshipModuleConfig name;
  mkLib = import ../../lib.nix {inherit config;};

  bg = mkLib.colors.brown_500;
  fg = mkLib.colors.light_blue_300;
  fg_remote = mkLib.colors.light_blue_800;
in {
  options = mkLib.mkSetStarshipModuleOptions name {
    disabled = lib.mkEnableOption "Disable starship ${name} module.";

    position = lib.mkOption {
      type = lib.types.str;
      description = "Position of the module (right or left)";
      default = "left";
    };
  };

  config = {
    programs = {
      starship = {
        settings = {
          ${name} = {
            inherit
              (cfg)
              disabled
              ;
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
          };
        };
      };
    };
  };
}
