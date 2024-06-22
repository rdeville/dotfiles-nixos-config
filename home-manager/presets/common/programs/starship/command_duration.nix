{
  lib,
  colors,
  sep,
  ...
}: let
  bg = colors.material-all.grey_700;
  fg = colors.material-all.yellow_200;
  # emphasis
  em = "bold";
in {
  # Disables the module.
  disabled = false;

  # Shortest duration to show time for (in milliseconds).
  min_time = 5000;
  # Show milliseconds in addition to seconds for the duration.
  show_milliseconds = false;
  # Show desktop notifications when command completes.
  show_notifications = true;
  # Shortest duration for notification (in milliseconds).
  min_time_to_notify = 45000;
  # Duration to show notification for (in milliseconds).
  notification_timeout = 5000;

  # The style of the module.
  style = "${em} bg:${bg} fg:${fg}";

  # The format for the module.
  format = lib.concatStrings [
    "[${sep.right}](bg:${sep.clr} fg:${bg})"
    "[ 󰄉 $duration ]($style)"
    "[${sep.right}](fg:${sep.clr} bg:${bg})"
  ];
}
