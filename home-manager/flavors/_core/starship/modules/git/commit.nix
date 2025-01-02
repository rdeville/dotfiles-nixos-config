{
  config,
  lib,
  ...
}: let
  name = "git_commit";
  cfg = mkLib.mkGetSarshipModuleConfig name;
  mkLib = import ../../lib.nix {inherit config;};

  sep = mkLib.sep.${cfg.position};
  bg = mkLib.colors.brown_500;
  fg_commit = mkLib.colors.blue_500;
  fg_tag = mkLib.colors.deep_purple_300;
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
              (sep bg)
              "[ $hash](bg:${bg} fg:${fg_commit})"
              "[$tag](bold bg:${bg} fg:${fg_tag})"
            ];
          };
        };
      };
    };
  };
}
