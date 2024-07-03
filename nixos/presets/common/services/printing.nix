{cfg, ...}: {
  services = {
    # CUPS
    printing = {
      enable = cfg.presets.main;
    };
  };
}
