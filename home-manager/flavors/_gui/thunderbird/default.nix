{
  config,
  lib,
  ...
}: let
  name = builtins.baseNameOf ../.;
  subname = builtins.baseNameOf ./.;
  cfg = config.hm.flavors.${name}.${subname};
in {
  options = {
    hm = {
      flavors = {
        ${name} = {
          ${subname} = {
            enable =
              lib.mkDependEnabledOption ''
                Install ${name}.${subname} Home-Manager flavor.
              ''
              config.hm.flavors.${name}.enable;
          };
        };
      };
    };
  };

  config = lib.mkIf (cfg.enable && (! config.hm.isDarwin)) {
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
              "mail.openpgp.fetch_pubkeys_from_gnupg" = true;
            };
          };
        };
      };
    };
  };
}
