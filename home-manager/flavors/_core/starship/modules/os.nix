{
  config,
  lib,
  ...
}: let
  name = "os";
  cfg = mkLib.mkGetSarshipModuleConfig name;
  mkLib = import ../lib.nix {inherit config;};

  sep = mkLib.sep.${cfg.position};
  fg = mkLib.colors.grey_100;
  bg = mkLib.colors.grey_700;
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
            # A table that maps each operating system to its symbol.
            symbols = {
              Arch = "[ ](bg:${bg} fg:${mkLib.colors.blue_400})";
              Debian = "[ ](bg:${bg} fg:${mkLib.colors.red_400})";
              Linux = "[ ](bg:${bg} fg:${mkLib.colors.yellow_400})";
              Macos = "[ ](bg:${bg} fg:${mkLib.colors.grey_100})";
              NixOS = "[ ](bg:${bg} fg:${mkLib.colors.blue_400})";
              Raspbian = "[ ](bg:${bg} fg:${mkLib.colors.pink_400})";
              Ubuntu = "[ ](bg:${bg} fg:${mkLib.colors.orange_400})";
              Unknown = "❓";
            };
            # The style used for the module
            style = "bg:${bg} fg:${fg}";
            #The format for the module.
            format = lib.concatStrings [
              (sep bg)
              "[ $symbol ]($style)"
            ];
          };
        };
      };
    };
  };
}
