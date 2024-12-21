{
  config,
  pkgs,
  ...
}: let
  linuxPkgs = [];
  darwinPkgs = [];
  cfg = config.hm;
in {
  home = {
    packages = with pkgs;
      [
        alejandra
        age
        colmena
        comma
        ghostscript
      ]
      ++ (
        if cfg.isDarwin
        then darwinPkgs
        else linuxPkgs
      );
  };
}
