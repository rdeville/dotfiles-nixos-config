{
  lib,
  colors,
  sep,
  ...
}: let
  fg = colors.material-all.yellow_300;
  bg = colors.material-all.grey_700;
in {
  # Disables the username module.
  disabled = false;

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
    "[${sep.right}](bg:${sep.clr} fg:${bg})"
    "[ 󱑒 $time ]($style)"
    "[${sep.right}](bg:${bg} fg:${sep.clr})"
  ];
}
