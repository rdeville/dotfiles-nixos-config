{
  mkLib,
  userCfg,
  ...
}: let
  domain = "romaindeville.ovh";
  passwordCommand =
    if userCfg.username == "root"
    then ["cat" "/root/.config/sops-nix/secrets/accounts/${address}"]
    else ["cat" "/home/${userCfg.username}/.config/sops-nix/secrets/accounts/${address}"];
  address = "contact@${domain}";
  userName = "rdeville";
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
      primary = true;
      defaultCalendar = "🤖 Personal";
      inherit
        userName
        address
        passwordCommand
        ;
    };
    contact = {
      url = "https://cloud.romaindeville.ovh/remote.php/dav/contacs/rdeville/";
      primary = true;
      inherit
        userName
        address
        passwordCommand
        ;
    };
  };
in {
  name = user.email.address;
  value = user;
}
