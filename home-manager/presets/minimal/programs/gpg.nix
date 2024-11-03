{
  pkgs,
  userCfg,
  ...
}: let
  homedir =
    if userCfg.isDarwin
    then "/Users/${userCfg.username}/.local/share/gnupg"
    else "/home/${userCfg.username}/.local/share/gnupg";
in {
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
}
