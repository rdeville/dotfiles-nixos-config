{
  mkLib,
  userCfg,
  tuiAccounts,
  guiAccounts,
  ...
}: let
  domain = "romaindeville.fr";
  address = "contact@${domain}";
  slugAddress = builtins.replaceStrings ["@" "."] ["_at_" "_"] address;
  userName = "rdeville";
  passwordCommand =
    if userCfg.username == "root"
    then ["cat" "/root/.config/sops-nix/secrets/accounts/${address}"]
    else ["cat" "/home/${userCfg.username}/.config/sops-nix/secrets/accounts/${address}"];
  primary = userCfg.presets.main && !userCfg.presets.work;
  displayName = "📗 Romain Deville";
  user = {
    email = {
      realName = "Romain Deville";
      imap = mkLib.mkImap domain "SSL/TLS";
      smtp = mkLib.mkSmtp domain "STARTTLS";
      aliases = [];
      passwordCommand = builtins.toString passwordCommand;
      inherit
        address
        userName
        primary
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
