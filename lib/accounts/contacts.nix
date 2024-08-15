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
    enable = true;
    defaultCollection =
      if userAccount.contact ? defaultCollection && userAccount.contact.defaultCollection != null
      then userAccount.contact.defaultCollection
      else "contacts";
  };
  vdirsyncer = {
    enable = true;
    collections = ["from a" "from b"];
    conflictResolution = ["b wins"];
  };
}
