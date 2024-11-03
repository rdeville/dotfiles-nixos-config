{
  userCfg,
  pkgs,
  lib,
  ...
}:
lib.mkIf (! userCfg.isDarwin) {
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
