{userAccount, ...}: {
  primary =
    if userAccount.calendar ? primary
    then userAccount.calendar.primary
    else false;
  khal = {
    enable =
      if userAccount.calendar ? khal && userAccount.calendar.khal ? enabled
      then userAccount.calendar.khal.enabled
      else false;
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
    enable =
      if userAccount.calendar ? vdirsyncer && userAccount.calendar.vdirsyncer ? enabled
      then userAccount.calendar.vdirsyncer.enabled
      else false;
    collections = ["from a" "from b"];
    conflictResolution = ["b wins"];
    metadata = ["displayname" "color"];
  };
}
