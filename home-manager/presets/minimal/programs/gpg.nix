{pkgs, ...}: {
  programs = {
    gpg = {
      enable = true;
      homedir = "/home/rdeville/.local/share/gnupg/";
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
}
