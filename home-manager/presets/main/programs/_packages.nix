{
  pkgs,
  userCfg,
  ...
}: let
  linuxPkgs = with pkgs; [
    whatsapp-for-linux
  ];
  darwinPkgs = [];
in {
  home = {
    packages = with pkgs;
      [
        alejandra
        discord
        ghostscript
        signal-desktop
        colmena
      ]
      ++ (
        if userCfg.isDarwin
        then darwinPkgs
        else linuxPkgs
      );
  };
}
