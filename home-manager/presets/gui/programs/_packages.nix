{
  config,
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
        if config.hm.isDarwin
        then darwinPkgs
        else linuxPkgs
      );
  };
}
