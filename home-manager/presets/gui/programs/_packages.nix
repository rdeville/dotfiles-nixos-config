{
  userCfg,
  pkgs,
  ...
}: let
  linuxPkgs = with pkgs; [
    keepassxc
  ];
  darwinPkgs = [];
in {
  home = {
    packages = with pkgs;
      [
        arandr
      ]
      ++ (
        if userCfg.isDarwin
        then darwinPkgs
        else linuxPkgs
      );
  };
}
