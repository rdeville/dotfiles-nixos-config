{
  userCfg,
  lib,
  ...
}:
lib.mkIf (! userCfg.isDarwin) {
  services = {
    dunst = {
      enable = true;
    };
  };
}
