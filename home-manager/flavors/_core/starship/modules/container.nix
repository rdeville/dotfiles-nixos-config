{
  config,
  lib,
  ...
}: let
  name = "container";
  cfg = mkLib.mkGetSarshipModuleConfig name;
  mkLib = import ../lib.nix {inherit config;};

  sep = mkLib.sep.${cfg.position};
  bg = mkLib.colors.blue_300;
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
            # The format of a git repo when before_repo_root_style and repo_root_style is defined.
            symbol = "⬢ ";
            # The style for the module.
            style = "bg:${bg} fg:${fg}";
            # The format for the module.
            format = lib.concatStrings [
              (sep bg)
              "[ $symbol$name ]($style)"
            ];
          };
        };
      };
    };
  };
}
