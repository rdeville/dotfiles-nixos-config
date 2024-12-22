{contact, ...}: {
  local = {
    type = "filesystem";
    fileExt = ".vcf";
  };
  remote = {
    passwordCommand = contact.passwordCommand;
    type = "carddav";
    url = contact.url;
    userName = contact.userName;
  };
  khard = {
    enable =
      if contact ? khard && contact.khard ? enabled
      then contact.khard.enabled
      else false;
    defaultCollection =
      if contact ? defaultCollection && contact.defaultCollection != null
      then contact.defaultCollection
      else "contacts";
  };
  vdirsyncer = {
    enable =
      if contact ? vdirsyncer && contact.vdirsyncer ? enabled
      then contact.vdirsyncer.enabled
      else false;
    collections = ["from a" "from b"];
    conflictResolution = ["b wins"];
  };
}
