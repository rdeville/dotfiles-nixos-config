{
  config,
  lib,
  ...
}: let
  name = "sudo";
  cfg = mkLib.mkGetSarshipModuleConfig name;
  mkLib = import ../lib.nix {inherit config;};

  fg = mkLib.colors.red_300;
  bg = mkLib.colors.grey_800;
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
            # The symbol displayed when credentials are cached
            symbol = " ";
            # The style of the module.
            style = "bold bg:${bg} fg:${fg}";
            # The format for the module.
            format = lib.concatStrings [
              "[$symbol ]($style)"
            ];
          };
        };
      };
    };
  };
}
