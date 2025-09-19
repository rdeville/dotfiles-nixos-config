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
              enable =
                lib.mkDependEnabledOption ''
                  Install ${name}.${subname}.${subsubname} Home-Manager flavor.
                ''
                (
                  config.hm.flavors.${name}.enable
                  && config.hm.flavors.${name}.${subname}.enable
                  && config.hm.flavors.${name}.${subname}.hyprland.enable
                );

              wallpaperDir = lib.mkOption {
                type = lib.types.path;
                description = ''
                  Path containing image for the wallpaper randomizer.
                  Default to folder `wallpapers` of this flavor.
                '';
                default = ./wallpapers;
              };

              wallpaperRefresh = lib.mkOption {
                type = lib.types.int;
                description = ''
                  Time in minutes between wallpaper randomization.
                '';
                default = 60;
              };
            };
          };
        };
      };
    };
  };

  config = lib.mkIf cfg.enable (let
    # Randomize wallpaper every 6 hours, adaptated from hyprpaper to swww
    # From : https://github.com/hyprwm/hyprpaper/issues/108#issuecomment-2119611893
    wallpapers = lib.filesystem.listFilesRecursive cfg.wallpaperDir;

    wallpaperBashArray = "(\"${
      lib.strings.concatStrings (
        lib.strings.intersperse "\" \"" (map (wallpaper: "${wallpaper}") wallpapers)
      )
    }\")";
    wallpaperRandomizer = pkgs.writeShellScriptBin "wallpaperRandomizer" ''
      wallpapers=${wallpaperBashArray}
      rand=$[$RANDOM % ''${#wallpapers[@]}]
      wallpaper=''${wallpapers[$rand]}

      monitor=(`hyprctl monitors | grep Monitor | awk '{print $2}'`)
      swww img $wallpaper \
        --transition-type wipe \
        --transition-fps 255 \
        --transition-step 255 --transition-duration 1
    '';
  in {
    home = {
      packages = with pkgs; [
        swww
        wallpaperRandomizer
      ];
    };

    systemd = {
      user = {
        services = {
          wallpaperRandomizer = {
            Install = {
              WantedBy = ["graphical-session.target"];
            };

            Unit = {
              Description = "Set random desktop background using swww";
              After = [
                "hyrpland.target"
              ];
              PartOf = [
                "graphical-session.target"
              ];
            };

            Service = {
              Type = "oneshot";
              ExecStart = "${wallpaperRandomizer}/bin/wallpaperRandomizer";
              IOSchedulingClass = "idle";
            };
          };
        };

        timers.wallpaperRandomizer = {
          Unit = {
            Description = "Set random desktop background using swww on an interval";
          };
          Timer = {
            OnUnitActiveSec = "${toString cfg.wallpaperRefresh}m";
          };
          Install = {
            WantedBy = ["timers.target"];
          };
        };
      };
    };
  });
}
