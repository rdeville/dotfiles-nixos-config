{
  config,
  lib,
  pkgs,
  ...
}: let
  name = builtins.baseNameOf ./.;
  subname = "gpg";
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

  config = lib.mkIf cfg.enable {
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
