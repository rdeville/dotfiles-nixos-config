{config, ...}: {
  xdg = {
    configFile = {
      "user-dirs.locale" ={
        text = "en_US";
      };
    };
    userDirs = {
      # I usually have only three home folder: cloud, git and downloads
      createDirectories = false;
      enable = false;
      desktop = "${config.home.homeDirectory}/"
      documents = "${config.home.homeDirectory}/"
      download = "${config.home.homeDirectory}/downloads"
      extraConfig = "${config.home.homeDirectory}/"
      music = "${config.home.homeDirectory}/"
      pictures = "${config.home.homeDirectory}/"
      publicShare = "${config.home.homeDirectory}/public"
      templates = "${config.home.homeDirectory}/"
      videos = "${config.home.homeDirectory}/"
    };
  };
}
