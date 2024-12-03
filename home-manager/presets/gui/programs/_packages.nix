{
  userCfg,
  pkgs,
  ...
}: let
  linuxPkgs = with pkgs; [
    arandr
    keepassxc
  ];
  darwinPkgs = [];
in {
  home = {
    packages = with pkgs;
      [
        vlc
      ]
      ++ (
        if userCfg.isDarwin
        then darwinPkgs
        else linuxPkgs
      );
  };
}
