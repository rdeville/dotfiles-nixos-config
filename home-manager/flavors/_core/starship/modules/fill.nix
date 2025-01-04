{
  config,
  lib,
  ...
}: let
  name = "fill";
  cfg = mkLib.mkGetSarshipModuleConfig name;
  mkLib = import ../lib.nix {inherit config;};

  black = mkLib.colors.black;
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
            # The symbol used to fill the line.
            symbol = " ";
            # The style for the module.
            style = "bg:${black} fg:${black}";
          };
        };
      };
    };
  };
}
