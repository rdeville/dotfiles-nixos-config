{
  config,
  lib,
  ...
}: let
  name = "git_state";
  cfg = mkLib.mkGetSarshipModuleConfig name;
  mkLib = import ../../lib.nix {inherit config;};

  sep = mkLib.sep.${cfg.position};
  bg = mkLib.colors.red_500;
  fg = mkLib.colors.white;
in {
  options = mkLib.mkSetStarshipModuleOptions name {
    disabled = lib.mkEnableOption "Disable starship ${name} module.";

    position = lib.mkOption {
      type = lib.types.str;
      description = "Position of the module (right or left)";
      default = "right";
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
            style = "bold fg:${fg} bg:${bg}";
            # The format for the module.
            format = lib.concatStrings [
              (sep bg)
              "[ $state ($progress_current/$progress_total) ]($style)"
            ];
          };
        };
      };
    };
  };
}
