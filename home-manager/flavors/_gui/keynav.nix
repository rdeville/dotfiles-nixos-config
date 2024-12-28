{
  config,
  pkgs,
  lib,
  ...
}:
lib.mkIf (! config.hm.isDarwin) {
  home = {
    packages = with pkgs; [
      keynav
    ];
  };

  services = {
    keynav = {
      enable = true;
    };
  };
}
