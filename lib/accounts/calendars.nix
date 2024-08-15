{userAccount, ...}: {
  primary = userAccount.calendar.primary;
  khal = {
    enable = true;
    addresses = [userAccount.email.address] ++ userAccount.email.aliases;
    priority =
      if userAccount.calendar.primary
      then 1000
      else 1;
    type = "discover";
  };
  local = {
    type = "filesystem";
  };
  primaryCollection = userAccount.calendar.defaultCalendar;
  remote = {
    passwordCommand = userAccount.calendar.passwordCommand;
    type = "caldav";
    url = userAccount.calendar.url;
    userName = userAccount.calendar.userName;
  };
  vdirsyncer = {
    enable = true;
    collections = ["from a" "from b"];
    conflictResolution = ["b wins"];
    metadata = ["displayname" "color"];
  };
}
