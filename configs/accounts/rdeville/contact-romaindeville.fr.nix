{
  mkLib,
  userCfg,
  ...
}: let
  domain = "romaindeville.fr";
  passwordCommand =
    if userCfg.username == "root"
    then ["cat" "/root/.config/sops-nix/secrets/accounts/${address}"]
    else ["cat" "/home/${userCfg.username}/.config/sops-nix/secrets/accounts/${address}"];
  # accountName = "🟩 Romain Deville";
  address = "contact@${domain}";
  userName = "rdeville";
  primary = userCfg.presets.main && !userCfg.presets.work;
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
in {
  name = user.email.address;
  value = user;
}
