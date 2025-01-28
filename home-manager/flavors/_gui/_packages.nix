{
  config,
  pkgs,
  ...
}: let
  linuxPkgs = with pkgs; [
    arandr
    kolourpaint
    vlc
  ];
  darwinPkgs = [];
in {
  home = {
    packages = with pkgs;
      [
        keepassxc
      ]
      ++ (
        if config.hm.isDarwin
        then darwinPkgs
        else linuxPkgs
      );
  };
}
