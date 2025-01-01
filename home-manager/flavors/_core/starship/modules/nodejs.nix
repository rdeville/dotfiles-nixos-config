{
  config,
  lib,
  ...
}: let
  name = "nodejs";
  cfg = mkLib.mkGetSarshipModuleConfig name;
  mkLib = import ../lib.nix {inherit config;};

  sep = mkLib.sep.${cfg.position};
  bg = mkLib.colors.yellow_300;
  fg = mkLib.colors.grey_900;
  red = mkLib.colors.red_300;
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
            # A format string representing the symbol of Node.js.
            symbol = "󰎙 ";
            # The version format. Available vars are raw, major, minor, & patch
            version_format = "v\${raw}";
            # Which extensions should trigger this module.
            detect_extensions = ["js" "mjs" "cjs" "ts" "mts" "cts"];
            # Which filenames should trigger this module.
            detect_files = ["package.json" ".node-version"];
            # Which folders should trigger this module.
            detect_folders = ["node_modules"];
            # The style for the module when an engines property in package.json does not
            # match the Node.js version.
            not_capable_style = "bg:${bg} fg:${red}";
            # The style of the module.
            style = "bg:${bg} fg:${fg}";
            # The format for the module.
            format = lib.concatStrings [
              (sep bg)
              "[ $symbol$version]($style)"
            ];
          };
        };
      };
    };
  };
}
