{
  config,
  lib,
  ...
}: let
  name = "terraform";
  cfg = mkLib.mkGetSarshipModuleConfig name;
  mkLib = import ../lib.nix {inherit config;};

  sep = mkLib.sep.${cfg.position};
  bg = mkLib.colors.deep_purple_800;
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
            # A format string shown before the terraform workspace.
            symbol = "󱁢 ";
            # The version format. Available vars are raw, major, minor, & patch
            version_format = "v\${raw}";
            # Which extensions should trigger this module.
            detect_extensions = ["tf" "tfplan" "tfstate" "hcl"];
            # Which filenames should trigger this module.
            detect_files = [];
            # Which folders should trigger this module.
            detect_folders = [".terraform"];
            # The style used for the module
            style = "bg:${bg} fg:${fg}";
            # The format for the module.
            format = lib.concatStrings [
              (sep bg)
              "[ $symbol$version:$workspace ]($style)"
            ];
          };
        };
      };
    };
  };
}
