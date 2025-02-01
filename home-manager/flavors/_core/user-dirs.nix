{
  config,
  lib,
  ...
}: let
  name = builtins.baseNameOf ./.;
  subname = "locale";
  cfg = config.hm.flavors.${name}.${subname};
in {
  options = {
    hm = {
      flavors = {
        ${name} = {
          ${subname} = {
            enable =
              lib.mkDependEnabledOption ''
                Install ${name}.${subname} Home-Manager flavor.
              ''
              config.hm.flavors.${name}.enable;

            text = lib.mkOption {
              type = lib.types.str;
              description = "User Dirs locale i18n configuration.";
              default = "en_US";
            };
          };
        };
      };
    };
  };

  config = lib.mkIf cfg.enable {
    xdg = lib.mkIf (! config.hm.isDarwin) {
      configFile = {
        "user-dirs.locale" = {
          inherit (cfg) text;
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
