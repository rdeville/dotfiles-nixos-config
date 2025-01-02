{
  config,
  lib,
  ...
}: let
  name = "time";
  cfg = mkLib.mkGetSarshipModuleConfig name;
  mkLib = import ../lib.nix {inherit config;};

  sep = mkLib.sep.${cfg.position};
  fg = mkLib.colors.yellow_300;
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
            # Enables 12 hour formatting
            use_12hr = false;
            # The chrono format string used to format the time.
            time_format = "%H:%M:%S";
            # Sets the UTC offset to use. Range from -24 < x < 24. Allows floats to
            # accommodate 30/45 minute timezone offsets.
            utc_time_offset = "local";
            # Sets the time range during which the module will be shown. Times must be
            # specified in 24-hours format
            time_range = "21:00:00-02:00:00";
            # The style used for the module
            style = "bg:${bg} fg:${fg}";
            #The format for the module.
            format = lib.concatStrings [
              (sep bg)
              "[ 󱑒 $time ]($style)"
            ];
          };
        };
      };
    };
  };
}
