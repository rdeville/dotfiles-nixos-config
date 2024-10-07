{
  mkLib,
  userCfg,
  tuiAccounts,
  guiAccounts,
  ...
}: let
  domain = "romaindeville.ovh";
  address = "contact@${domain}";
  slugAddress = builtins.replaceStrings ["@" "."] ["_at_" "_"] address;
  userName = "rdeville";
  passwordCommand =
    if userCfg.username == "root"
    then ["cat" "/root/.config/sops-nix/secrets/${address}"]
    else ["cat" "/home/${userCfg.username}/.config/sops-nix/secrets/${address}"];
  displayName = "📘 Romain Deville";
  user = {
    email = {
      realName = "Romain Deville";
      imap = mkLib.mkImap domain "SSL/TLS";
      smtp = mkLib.mkSmtp domain "STARTTLS";
      passwordCommand = builtins.toString passwordCommand;
      aliases = [];
      inherit
        address
        userName
        ;
    };
    calendar = {
      url = "https://cloud.romaindeville.ovh/remote.php/dav/calendars/rdeville/";
      primary = userCfg.presets.main && !userCfg.presets.work;
      defaultCalendar = "🤖 Personal";
      inherit
        userName
        address
        passwordCommand
        ;
    };
    contact = {
      url = "https://cloud.romaindeville.ovh/remote.php/dav/addressbooks/users/rdeville/contacts/";
      primary = userCfg.presets.main && !userCfg.presets.work;
      inherit
        userName
        address
        passwordCommand
        ;
    };
  };
in [
  {
    name = displayName;
    value = {
      inherit address;
      email =
        if user ? email
        then user.email // guiAccounts.email
        else {};
      calendar =
        if user ? calendar
        then user.calendar // guiAccounts.calendar
        else {};
      contact =
        if user ? contact
        then user.contact // guiAccounts.contact
        else {};
    };
  }
  {
    name = slugAddress;
    value = {
      inherit address;
      email =
        if user ? email
        then user.email // tuiAccounts.email
        else {};
      calendar =
        if user ? calendar
        then user.calendar // tuiAccounts.calendar
        else {};
      contact =
        if user ? contact
        then user.contact // tuiAccounts.contact
        else {};
    };
  }
]
