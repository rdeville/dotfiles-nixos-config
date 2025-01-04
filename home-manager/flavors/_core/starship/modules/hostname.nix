{
  config,
  lib,
  ...
}: let
  name = "hostname";
  cfg = mkLib.mkGetSarshipModuleConfig name;
  mkLib = import ../lib.nix {inherit config;};

  sep = mkLib.sep.${cfg.position};
  fg = mkLib.colors.grey_900;
  bg = mkLib.colors.yellow_300;
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
            # Only show hostname when connected to an SSH session.
            ssh_only = false;
            # A format string representing the symbol when connected to SSH session.
            ssh_symbol = "󰢹 ";
            # String that the hostname is cut off at, after the first match. '.' will stop after the first dot. '' will disable any truncation.
            trim_at = ".";
            # The style used for the module
            style = "bg:${bg} fg:${fg}";
            #The format for the module.
            format = lib.concatStrings [
              (sep bg)
              "[ 󰇄 $ssh_symbol$hostname ]($style)"
            ];
          };
        };
      };
    };
  };
}
