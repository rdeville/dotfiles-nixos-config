{config, ...}: {
  xdg = {
    configFile = {
      "user-dirs.locale" = {
        text = "en_US";
      };
    };
    userDirs = {
      # I usually have only three home folder: cloud, git and downloads
      createDirectories = false;
      enable = true;
      desktop = "${config.home.homeDirectory}/";
      documents = "${config.home.homeDirectory}/";
      download = "${config.home.homeDirectory}/downloads";
      music = "${config.home.homeDirectory}/";
      pictures = "${config.home.homeDirectory}/";
      publicShare = "${config.home.homeDirectory}/public";
      templates = "${config.home.homeDirectory}/";
      videos = "${config.home.homeDirectory}/";
      extraConfig = {
        XDG_CONFIG_HOME = config.xdg.configHome;
        XDG_DATA_HOME = config.xdg.dataHome;
        XDG_CACHE_HOME = config.xdg.cacheHome;
      };
    };
  };
}
