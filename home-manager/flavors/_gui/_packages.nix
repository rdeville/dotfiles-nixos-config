{
  config,
  pkgs,
  ...
}: let
  linuxPkgs = with pkgs; [
    arandr
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
