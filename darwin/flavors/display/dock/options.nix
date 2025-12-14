{
  config,
  lib,
  ...
}: let
  name = builtins.baseNameOf ../.;
  subname = builtins.baseNameOf ./.;
in {
  options = {
    os = {
      flavors = {
        ${name} = {
          ${subname} = {
            enable =
              lib.mkDependEnabledOption ''
                Install ${name}.${subname} Darwin flavor.
              ''
              config.os.flavors.${name}.enable;

            autohide = lib.mkDefaultEnabledOption ''Enable hiding the dock'';
            dashboard-in-overlay =
              lib.mkEnableOption
              ''Whether to hide Dashboard as a Space'';
            expose-group-apps =
              lib.mkEnableOption
              ''Whether to group windows by application in Mission Control's Exposé'';

            largesize = lib.mkOption {
              type = lib.types.int;
              description = ''Magnified icon size on hover'';
              default = null;
            };
            launchanim =
              lib.mkEnableOption
              ''Animate opening applications from the Dock'';

            magnification = lib.mkEnableOption ''Magnify icon on hover'';

            mineffect = lib.mkOption {
              type = lib.types.enum [
                "scale"
                "genie"
                "suck"
              ];
              description = ''Set the minimize/maximize window effect'';
              default = "scale";
            };

            minimize-to-application =
              lib.mkEnableOption
              ''Whether to minimize windows into their application icon'';
            mouse-over-hilite-stack =
              lib.mkEnableOption
              ''Enable highlight hover effect for the grid view of a stack in the Dock'';
            mru-spaces =
              lib.mkEnableOption
              ''Whether to automatically rearrange spaces based on most recent use'';
            orientation = lib.mkOption {
              type = lib.types.enum [
                "bottom"
                "left"
                "right"
              ];
              description = ''Position of the dock on screen'';
              default = "bottom";
            };
            # TODO: persistent-apps: Persistent applications, spacers, files, and folders in the dock
            # TODO: persistent-others: Persistent files, and folders in the dock

            scroll-to-open =
              lib.mkEnableOption
              ''
                Scroll up on a Dock icon to show all Space's opened windows for an
                app, or open stack
              '';
            showDesktopGestureEnabled =
              lib.mkDefaultEnabledOption
              ''
                Whether to enable four-finger spread gesture to show the
                Desktop.
              '';
            show-process-indicators =
              lib.mkDefaultEnabledOption
              ''Show indicator lights for open applications in the Dock'';
            show-recents =
              lib.mkEnableOption
              ''Show recent applications in the dock'';
            tilesize = lib.mkOption {
              type = lib.types.int;
              description = ''Size of the icons in the dock'';
              default = 32;
            };
            # For below configurations, integer values represent following
            # actions:
            # 1: Disabled
            # 2: Mission Control
            # 3: Application Windows
            # 4: Desktop
            # 5: Start Screen Saver
            # 6: Disable Screen Saver
            # 7: Dashboard
            # 10: Put Display to Sleep
            # 11: Launchpad
            # 12: Notification Center
            # 13: Lock Screen
            # 14: Quick Note.
            wvous-bl-corner = lib.mkOption {
              type = lib.types.int;
              description = ''Hot corner action for bottom left corner'';
              default = 1;
            };
            wvous-br-corner = lib.mkOption {
              type = lib.types.int;
              description = ''Hot corner action for bottom right corner'';
              default = 1;
            };
            wvous-tl-corner = lib.mkOption {
              type = lib.types.int;
              description = ''Hot corner action for top left corner'';
              default = 1;
            };
            wvous-tr-corner = lib.mkOption {
              type = lib.types.int;
              description = ''Hot corner action for top right corner'';
              default = 1;
            };
          };
        };
      };
    };
  };
}
