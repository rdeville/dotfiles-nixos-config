{
  config,
  pkgs,
  ...
}: let
  homedir = "${config.home.homeDirectory}/.local/share/gnupg";
in {
  config = {
    programs = {
      gpg = {
        inherit homedir;
        enable = true;
      };
    };
    services = {
      gpg-agent = {
        enable = true;
        defaultCacheTtl = 3600;
        maxCacheTtl = 3600;
        pinentryPackage = pkgs.pinentry-tty;
      };
    };
  };
}
