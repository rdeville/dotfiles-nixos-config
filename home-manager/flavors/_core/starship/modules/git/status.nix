{
  config,
  lib,
  ...
}: let
  name = "git_status";
  cfg = mkLib.mkGetSarshipModuleConfig name;
  mkLib = import ../../lib.nix {inherit config;};

  bg = mkLib.colors.brown_500;
  fg_conflict = mkLib.colors.red_500;
  fg_ahead = mkLib.colors.green_500;
  fg_behind = mkLib.colors.red_500;
  fg_diverged = mkLib.colors.red_500;
  fg_ok = mkLib.colors.green_500;
  fg_untracked = mkLib.colors.yellow_500;
  fg_stashed = mkLib.colors.pink_500;
  fg_modified = mkLib.colors.orange_500;
  fg_staged = mkLib.colors.green_500;
  fg_renamed = mkLib.colors.lime_500;
  fg_deleted = mkLib.colors.red_500;
  fg_type_changed = mkLib.colors.cyan_500;
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
          };
        };
      };
    };
  };
}
