{
  config,
  lib,
  pkgs,
  ...
}:
lib.mkIf (! config.hm.isDarwin) {
  home = {
    packages = with pkgs; [
      dunst
    ];
  };

  services = {
    dunst = {
      enable = true;
    };
  };
}
