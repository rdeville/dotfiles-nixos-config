{userAccount, ...}: {
  local = {
    type = "filesystem";
    fileExt = ".vcf";
  };
  remote = {
    passwordCommand = userAccount.contact.passwordCommand;
    type = "carddav";
    url = userAccount.contact.url;
    userName = userAccount.contact.userName;
  };
  khard = {
    enable =
      if userAccount.contact ? khard && userAccount.contact.khard ? enabled
      then userAccount.contact.khard.enabled
      else false;
    defaultCollection =
      if userAccount.contact ? defaultCollection && userAccount.contact.defaultCollection != null
      then userAccount.contact.defaultCollection
      else "contacts";
  };
  vdirsyncer = {
    enable =
      if userAccount.contact ? vdirsyncer && userAccount.contact.vdirsyncer ? enabled
      then userAccount.contact.vdirsyncer.enabled
      else false;
    collections = ["from a" "from b"];
    conflictResolution = ["b wins"];
  };
}
