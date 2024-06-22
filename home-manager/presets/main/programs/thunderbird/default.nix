{pkgs, ...}: {
  programs = {
    thunderbird = {
      enable = true;
      profiles = {
        rdeville = {
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
