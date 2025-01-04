{
  config,
  lib,
  ...
}: let
  name = "keepass";
  cfg = mkLib.mkGetSarshipModuleConfig name;
  mkLib = import ../../lib.nix {inherit config;};

  sep = mkLib.sep.${cfg.position};
  bg = mkLib.colors.light_green_600;
  fg = mkLib.colors.grey_900;
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
          env_var = {
            ${name} = {
              inherit
                (cfg)
                disabled
                ;
              # The symbol used before displaying the variable value.
              symbol = "󰌋 ";
              # The environment variable to be displayed.
              variable = "KEEPASS_NAME";
              # The default value to be displayed when the selected variable is not defined.
              default = "";
              # The description of the module that is shown when running starship explain.
              description = "Show the name of KEEPASS_NAME";
              # The style of the module.
              style = "bg:${bg} fg:${fg}";
              # The format for the module.
              format = lib.concatStrings [
                "("
                (sep bg)
                "[ $symbol$env_value ]($style)"
                ")"
              ];
            };
          };
        };
      };
    };
  };
}
