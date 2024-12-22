{
  config,
  pkgs,
  lib,
  ...
}: let
  domain = "romaindeville.fr";
  address = "contact@${domain}";
  slugAddress = builtins.replaceStrings ["@" "."] ["_at_" "_"] address;
  userName = "rdeville";
  secretPath = "accounts/${address}";
  passwordCommand = [
    "${pkgs.coreutils}/bin/cat"
    "${config.hm.homeDirectory}.config/sops-nix/secrets/${secretPath}"
  ];
  primary = config.hm.isMain && ! config.hm.isWork;
  displayName = "📗 Romain Deville";
  user = {
    email = {
      realName = "Romain Deville";
      imap = lib.mkImap domain "SSL/TLS";
      smtp = lib.mkSmtp domain "STARTTLS";
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
  inherit slugAddress displayName;
  email = user.email;
  sops = {
    ${secretPath} = {
      sopsFile = ./credentials.enc.yaml;
    };
  };
}
