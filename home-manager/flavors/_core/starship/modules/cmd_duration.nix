{
  config,
  lib,
  ...
}: let
  name = "cmd_duration";
  cfg = mkLib.mkGetSarshipModuleConfig name;
  mkLib = import ../lib.nix {inherit config;};

  sep = mkLib.sep.${cfg.position};
  bg = mkLib.colors.grey_700;
  fg = mkLib.colors.yellow_200;
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
            # Shortest duration to show time for (in milliseconds).
            min_time = 5000;
            # Show milliseconds in addition to seconds for the duration.
            show_milliseconds = false;
            # Show desktop notifications when command completes.
            show_notifications = true;
            # Shortest duration for notification (in milliseconds).
            min_time_to_notify = 60000;
            # Duration to show notification for (in milliseconds).
            notification_timeout = 5000;
            # The style of the module.
            style = "bg:${bg} fg:${fg} bold";
            # The format for the module.
            format = lib.concatStrings [
              (sep bg)
              "[ 󰄉 $duration ]($style)"
            ];
          };
        };
      };
    };
  };
}
