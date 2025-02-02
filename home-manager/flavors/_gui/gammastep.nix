{
  config,
  pkgs,
  lib,
  ...
}: let
  name = builtins.baseNameOf ./.;
  subname = "gammastep";
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
      gammastep = {
        enable = true;
        package = with pkgs; gammastep;
        dawnTime = "6:30-8:00";
        duskTime = "22:00-23:30";
        provider = "manual";
        temperature = {
          day = 6500;
          night = 4000;
        };
        tray = true;
        settings = {
          # Global settings for gammastep
          gammastep = {
            # Set the day and night screen temperatures
            # Disable the smooth fade between temperatures when gammastep starts and stops.
            fade = 1;
            # Set the screen brightness for day and nigh
            brightness-day = 1.0;
            brightness-night = 0.5;
            # Set the screen gamma (for all colors, or each color channel individually)
            gamma = 0.8;
            # Set the adjustment-method: 'randr', 'vidmode'
            adjustment-method = "randr";
          };
        };
      };
    };
  };
}
