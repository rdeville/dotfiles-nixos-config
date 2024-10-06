{userCfg, ...}: {
  # HACK: To inject userCfg in config
  config = userCfg.config;
}
