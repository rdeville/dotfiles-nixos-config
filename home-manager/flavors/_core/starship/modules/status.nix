{
  config,
  lib,
  ...
}: let
  name = "status";
  cfg = mkLib.mkGetSarshipModuleConfig name;
  mkLib = import ../lib.nix {inherit config;};

  sep = mkLib.sep.${cfg.position};
  fg = mkLib.colors.white;
  bg = mkLib.colors.red_500;
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
            # The symbol displayed on program error
            symbol = " ";
            # The symbol displayed on program success
            success_symbol = "";
            # The symbol displayed when file isn't executable
            not_executable_symbol = "󰳧 ";
            # The symbol displayed when the command can't be found
            not_found_symbol = " ";
            # The symbol displayed on SIGINT (Ctrl + c)
            sigint_symbol = "󰟾 ";
            # The symbol displayed on any signal
            signal_symbol = "󰠠 ";
            # Enable signal mapping from exit code
            recognize_signal_code = false;
            # Enable symbols mapping from exit code
            map_symbol = true;
            # Enable pipestatus reporting
            pipestatus = false;
            # The style for the module.
            style = "bold bg:${bg} fg:${fg}";
            # The format of the module
            format = lib.concatStrings [
              (sep bg)
              "[ $symbol$int ]($style)"
            ];
          };
        };
      };
    };
  };
}
