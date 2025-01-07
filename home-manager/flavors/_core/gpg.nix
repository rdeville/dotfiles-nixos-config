{
  config,
  lib,
  pkgs,
  ...
}: let
  name = builtins.baseNameOf ./.;
  cfg = config.hm.flavors.${name};
in
  lib.mkIf cfg.enable {
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
  }
