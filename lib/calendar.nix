{calendar, ...}: {
  inherit (calendar) primary;
  khal = {
    enable = calendar ? khal.enabled && calendar.khal.enabled;
    addresses =
      [calendar.address]
      ++ (
        if calendar ? aliases
        then calendar.aliases
        else []
      );
    priority =
      if calendar.primary
      then 1000
      else 1;
    type = "discover";
  };
  local = {
    type = "filesystem";
  };
  primaryCollection = calendar.defaultCalendar;
  remote = {
    passwordCommand = calendar.passwordCommand;
    type = "caldav";
    url = calendar.url;
    userName = calendar.userName;
  };
  vdirsyncer = {
    enable = calendar ? vdirsyncer.enabled && calendar.vdirsyncer.enabled;
    collections = ["from a" "from b"];
    conflictResolution = ["b wins"];
    metadata = ["displayname" "color"];
  };
}
