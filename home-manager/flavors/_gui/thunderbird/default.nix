{
  config,
  lib,
  ...
}:
lib.mkIf (! config.hm.isDarwin) {
  programs = {
    thunderbird = {
      enable = true;
      profiles = {
        "${config.hm.username}" = {
          isDefault = true;
          userChrome = builtins.readFile ./chrome/userChrome.css;
          withExternalGnupg = true;
          settings = {
            "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
            "mail.openpgp.allow_external_gnupg" = true;
          };
        };
      };
    };
  };
}
