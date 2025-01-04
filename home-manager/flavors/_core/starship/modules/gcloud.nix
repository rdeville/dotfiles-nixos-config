{
  config,
  lib,
  ...
}: let
  name = "gcloud";
  cfg = mkLib.mkGetSarshipModuleConfig name;
  mkLib = import ../lib.nix {inherit config;};

  sep = mkLib.sep.${cfg.position};
  bg = mkLib.colors.blue_800;
  fg = mkLib.colors.grey_100;
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
            # The symbol used before displaying the current GCP profile.
            symbol = "󱇶 ";

            # Table of region aliases to display in addition to the GCP name.
            region_aliases = {};
            # Table of project aliases to display in addition to the GCP name.
            project_aliases = {};
            # Which environmental variables should trigger this module
            detect_env_vars = [];

            # The style for the module.
            style = "bg:${bg} fg:${fg}";
            # The format for the module.
            format = lib.concatStrings [
              "("
              (sep bg)
              "[ $symbol$project$region ]($style)"
              ")"
            ];
          };
        };
      };
    };
  };
}
