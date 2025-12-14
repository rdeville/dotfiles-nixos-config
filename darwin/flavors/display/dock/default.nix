{config, ...}: let
  name = builtins.baseNameOf ../.;
  subname = builtins.baseNameOf ./.;
  cfg = config.os.flavors.${name}.${subname};
in {
  imports = [
    ./options.nix
  ];

  config = {
    system = {
      defaults = {
        dock = {
          inherit
            (cfg)
            autohide
            expose-group-apps
            largesize
            launchanim
            magnification
            mineffect
            minimize-to-application
            mouse-over-hilite-stack
            mru-spaces
            orientation
            scroll-to-open
            show-process-indicators
            show-recents
            wvous-bl-corner
            wvous-br-corner
            wvous-tl-corner
            wvous-tr-corner
            ;
        };
      };
    };
  };
}
