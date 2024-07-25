{
  pkgs,
  ...
}: {
  home = {
    packages = with pkgs; [
      redshift
    ];
  };
  services = {
    redshift = {
      enable = false;
      dawnTime = "6:30-8:00";
      duskTime = "22:00-23:30";
      provider = "manual";
      temperature = {
        day = 6500;
        night = 4000;
      };
      tray = true;
      settings = {
        # Global settings for redshift
        redshift = {
          # Set the day and night screen temperatures
          # Disable the smooth fade between temperatures when Redshift starts and stops.
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
}
