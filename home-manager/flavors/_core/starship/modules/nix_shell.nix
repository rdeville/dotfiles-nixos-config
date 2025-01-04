{
  config,
  lib,
  ...
}: let
  name = "nix_shell";
  cfg = mkLib.mkGetSarshipModuleConfig name;
  mkLib = import ../lib.nix {inherit config;};

  fg = mkLib.colors.blue_400;
  bg = mkLib.colors.grey_900;
  red = mkLib.colors.red_300;
  green = mkLib.colors.green_300;
  orange = mkLib.colors.orange_300;
  # emphasis
  em = "bold";
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
            # A format string representing the symbol of nix-shell.
            symbol = " ";
            # A format string shown when the shell is impure.
            impure_msg = "[ ](${em} bg:${bg} fg:${red})";
            # A format string shown when the shell is pure.
            pure_msg = "[ ](${em} bg:${bg} fg:${green})";
            # A format string shown when it is unknown if the shell is pure/impure.
            unknown_msg = "[ ](${em} bg:${bg} fg:${orange})";
            # Attempts to detect new nix shell-style shells with a heuristic.
            heuristic = false;
            # The style of the module.
            style = "bg:${bg} fg:${fg}";
            # The format for the module.
            format = lib.concatStrings [
              "[$symbol$state]($style)"
            ];
          };
        };
      };
    };
  };
}
