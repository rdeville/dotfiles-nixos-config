{
  accountsLib,
  userCfg,
  tuiAccounts,
  guiAccounts,
  pkgs,
  ...
}: let
  domain = "romaindeville.ovh";
  address = "contact@${domain}";
  slugAddress = builtins.replaceStrings ["@" "."] ["_at_" "_"] address;
  userName = "rdeville";
  passwordCommand =
    if userCfg.username == "root"
    then ["${pkgs.coreutils}/bin/cat" "/root/.config/sops-nix/secrets/accounts/${address}"]
    else ["${pkgs.coreutils}/bin/cat" "/home/${userCfg.username}/.config/sops-nix/secrets/accounts/${address}"];
  displayName = "📘 Romain Deville";
  user = {
    email = {
      realName = "Romain Deville";
      imap = accountsLib.mkImap domain "SSL/TLS";
      smtp = accountsLib.mkSmtp domain "STARTTLS";
      passwordCommand = builtins.toString passwordCommand;
      aliases = [];
      inherit
        address
        userName
        ;
    };
    calendar = {
      url = "https://cloud.romaindeville.ovh/remote.php/dav/calendars/rdeville/";
      primary = true; # userCfg.presets.main.enable; #  && !userCfg.presets ? work ? enable;
      defaultCalendar = "🤖 Personal";
      inherit
        userName
        address
        passwordCommand
        ;
    };
    contact = {
      url = "https://cloud.romaindeville.ovh/remote.php/dav/addressbooks/users/rdeville/contacts/";
      primary = true; # userCfg.presets.main.enable; # && !userCfg.presets ? work ? enable;
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
