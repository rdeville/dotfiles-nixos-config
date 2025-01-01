{
  config,
  lib,
  ...
}: let
  name = "git_metrics";
  cfg = mkLib.mkGetSarshipModuleConfig name;
  mkLib = import ../../lib.nix {inherit config;};

  bg = mkLib.colors.brown_500;
  fg_add = mkLib.colors.green_500;
  fg_del = mkLib.colors.red_500;
  fg = mkLib.colors.grey_500;
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
              "[ +$added]($added_style)"
              "[/](bg:${bg} fg:${fg})"
              "[-$deleted]($deleted_style)"
            ];
          };
        };
      };
    };
  };
}
