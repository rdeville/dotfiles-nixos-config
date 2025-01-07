{
  config,
  lib,
  ...
}: let
  name = builtins.baseNameOf ./.;
  cfg = config.hm.flavors.${name};
in {
  options = {
    hm = {
      flavors = {
        ${name} = {
          locale = lib.mkOption {
            type = lib.types.str;
            description = "User Dirs locale i18n configuration.";
            default = "en_US";
          };
        };
      };
    };
  };

  config = lib.mkIf cfg.enable {
    xdg = lib.mkIf (! config.hm.isDarwin) {
      configFile = {
        "user-dirs.locale" = {
          text = cfg.locale;
        };
      };

      userDirs = {
        # I usually have only three home folder: cloud, git and downloads, no need
        # for more XDG folder, except config, data or cache.
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
  };
}
