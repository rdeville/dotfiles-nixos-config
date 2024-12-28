{
  config,
  pkgs,
  ...
}: {
  config = {
    programs = {
      gpg = {
        homedir = "${config.xdg.dataHome}/gnupg";
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
