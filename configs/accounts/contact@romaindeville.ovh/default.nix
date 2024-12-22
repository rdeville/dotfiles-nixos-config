{
  config,
  pkgs,
  lib,
  ...
}: let
  domain = "romaindeville.ovh";
  address = "contact@${domain}";
  slugAddress = builtins.replaceStrings ["@" "."] ["_at_" "_"] address;
  userName = "rdeville";
  passwordCommand = [
    "${pkgs.coreutils}/bin/cat"
    "${config.hm.homeDirectory}.config/sops-nix/secrets/accounts/${address}"
  ];
  displayName = "📘 Romain Deville";
  user = {
    email = {
      realName = "Romain Deville";
      imap = lib.mkImap domain "SSL/TLS";
      smtp = lib.mkSmtp domain "STARTTLS";
      passwordCommand = builtins.toString passwordCommand;
      primary = false;
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
in {
  inherit slugAddress displayName;
  calendar = user.calendar;
  email = user.email;
  contact = user.contact;
}
