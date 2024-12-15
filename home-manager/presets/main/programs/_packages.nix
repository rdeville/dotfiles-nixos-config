{
  pkgs,
  userCfg,
  ...
}: let
  linuxPkgs = [ ];
  darwinPkgs = [];
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
        if userCfg.isDarwin
        then darwinPkgs
        else linuxPkgs
      );
  };
}
