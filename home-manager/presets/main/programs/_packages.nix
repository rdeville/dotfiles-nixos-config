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
        signal-desktop
      ]
      ++ (
        if userCfg.isDarwin
        then darwinPkgs
        else linuxPkgs
      );
  };
}
