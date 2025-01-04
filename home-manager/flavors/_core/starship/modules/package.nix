{
  config,
  lib,
  ...
}: let
  name = "package";
  cfg = mkLib.mkGetSarshipModuleConfig name;
  mkLib = import ../lib.nix {inherit config;};

  sep = mkLib.sep.${cfg.position};
  bg = mkLib.colors.deep_orange_300;
  fg = mkLib.colors.grey_900;
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
            # The symbol used before displaying the version the package.
            symbol = " ";
            # The version format. Available vars are raw, major, minor, & patch
            version_format = "v\${raw}";
            # Enable displaying version for packages marked as private.
            display_private = false;
            style = "bg:${bg} fg:${fg}";
            # The format for the module.
            format = lib.concatStrings [
              (sep bg)
              "[ $symbol$version ]($style)"
            ];
          };
        };
      };
    };
  };
}
