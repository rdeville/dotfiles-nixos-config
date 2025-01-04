{
  config,
  lib,
  ...
}: let
  name = "shlvl";
  cfg = mkLib.mkGetSarshipModuleConfig name;
  mkLib = import ../lib.nix {inherit config;};

  bg = mkLib.colors.grey_800;
  fg = mkLib.colors.grey_100;
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
            # The symbol used to represent the SHLVL.
            symbol = "";
            # Display threshold.
            threshold = 2;
            # Causes symbol to be repeated by the current SHLVL amount.
            repeat = false;
            # Decrements number of times symbol is repeated by the offset value
            repeat_offset = 0;
            # The style of the module.
            style = "bold bg:${bg} fg:${fg}";
            # The format for the module.
            format = lib.concatStrings [
              "[ $symbol$shlvl ]($style)"
            ];
          };
        };
      };
    };
  };
}
