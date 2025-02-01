{
  config,
  lib,
  ...
}: let
  name = builtins.baseNameOf ./.;
  subname = "picom";
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
          };
        };
      };
    };
  };

  config = lib.mkIf (cfg.enable && (! config.hm.isDarwin)) {
    services = {
      picom = {
        enable = true;
        backend = "xrender";
        # Shadow config
        shadow = false;
        # Fading config
        fade = true;
        fadeSteps = [
          3.0e-2
          3.0e-2
        ];
        fadeDelta = 3;
        # Opacity config
        inactiveOpacity = 0.75;
        activeOpacity = 1.0;
        menuOpacity = 0.75;
        opacityRules = [
          "100:name *= 'Firefox'"
          "100:name *= 'Picture-in-Picture'"
          "100:class_g *= 'vlc'"
          "100:name *= 'i3lock'"
        ];
        wintypes = {
          tooltip = {};
          normal = {};
          dock = {};
          dnd = {};
          popup_menu = {};
          dropdown_menu = {};
          above = {};
          splash = {};
          utility = {};
          notification = {
            opacity = 0.75;
          };
          desktop = {};
          menu = {};
          dialog = {};
        };
        vSync = true;
        settings = {
          log-level = "warn";
          show-all-xerrors = true;
        };
      };
    };
  };
}
