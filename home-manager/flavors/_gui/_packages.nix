{
  config,
  pkgs,
  ...
}: let
  linuxPkgs = with pkgs; [
    arandr
    kolourpaint
  ];
  darwinPkgs = [];
in {
  home = {
    packages = with pkgs;
      [
        keepassxc
        vlc
      ]
      ++ (
        if config.hm.isDarwin
        then darwinPkgs
        else linuxPkgs
      );
  };
}
