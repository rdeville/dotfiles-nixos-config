{
  config,
  lib,
  pkgs,
  ...
}: let
  name = builtins.baseNameOf ../../.;
  subname = builtins.baseNameOf ../.;
  subsubname = builtins.baseNameOf ./.;
  cfg = config.hm.flavors.${name}.${subname}.${subsubname};
in {
  options = {
    hm = {
      flavors = {
        ${name} = {
          ${subname} = {
            ${subsubname} = {
              enable = lib.mkOption {
                type = lib.types.bool;
                description = "Install ${name} Home-Manager flavor.";
                default = config.hm.flavors.${name}.${subname}.enable;
              };

              extraConfig = lib.mkOption {
                type = lib.types.lines;
                description = ''
                  Extra configuration lines to add to
                  `${config.xdg.configHome}/hypr/hyprlock.conf`.
                '';
                default = "";
              };
            };
          };
        };
      };
    };
  };

  config = lib.mkIf cfg.enable {
    home = {
      packages = with pkgs; [
        kolourpaint
        grim
        slurp
      ];
    };

    xdg = {
      configFile = {
        "hypr/${subsubname}" = {
          source = ./assets;
        };
      };
    };

    programs = {
      hyprlock = {
        inherit
          (cfg)
          enable
          extraConfig
          ;

        settings = {
          general = {
            # grace = 60;
          };
          # BACKGROUND
          background = {
            monitor = "";
            path = "${config.xdg.configHome}/hypr/${subsubname}/wallpaper.jpg";
            blur_passes = 2;
            contrast = 0.8916;
            brightness = 0.8172;
            vibrancy = 0.1696;
            vibrancy_darkness = 0.0;
            dots_size = 0.2;
            dots_spacing = 0;
            dots_center = true;
          };

          # INPUT FIELD
          input-field = {
            monitor = "";
            size = "50, 50";
            outline_thickness = 25;
            font_color = "rgba(0,0,0,0)";
            outer_color = "rgba(0,0,0,0)";
            inner_color = "rgba(0,0,0,0)";
            capslock_color = "rgba(186, 104, 200,0.5)";
            fade_on_empty = true;
            font_family = "FiraCode";
            hide_input = true;
            position = "0, -410";
            halign = "center";
            valign = "center";
          };

          animations = {
            enabled = false;
          };
        };
      };
    };
  };
}
