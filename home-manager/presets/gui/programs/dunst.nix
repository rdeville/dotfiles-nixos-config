{
  config,
  lib,
  ...
}:
lib.mkIf (! config.hm.isDarwin) {
  services = {
    dunst = {
      enable = true;
    };
  };
}
