{lib, ...}: let
  name = builtins.baseNameOf ./.;
in {
  options = {
    os = {
      flavors = {
        ${name} = {
          enable = lib.mkDefaultEnabledOption "Install ${name} NixOS flavors.";

          ActivityMonitor = {
            ShowCategory = lib.mkOption {
              type = lib.types.int;
              description = ''
                Change which processes to show.
                100: All Processes
                101: All Processes, Hierarchally
                102: My Processes
                103: System Processes
                104: Other User Processes
                105: Active Processes
                106: Inactive Processes
                107: Windowed Processes
              '';
              default = 101;
            };
          };

          controlcenter = {
            BatteryShowPercentage =
              lib.mkDefaultEnabledOption
              ''
                Apple menu > System Preferences > Control Center > Battery
                Show a battery percentage in menu bar.
              '';
            Bluetooth =
              lib.mkDefaultEnabledOption
              ''
                Apple menu > System Preferences > Control Center > Bluetooth
                Show a bluetooth control in menu bar. Default is null.
                18 = Display icon in menu bar 24 = Hide icon in menu bar.
              '';
            Display =
              lib.mkDefaultEnabledOption
              ''
                Apple menu > System Preferences > Control Center > Display
                Show a Screen Brightness control in menu bar. Default is null.
                18 = Display icon in menu bar 24 = Hide icon in menu bar.
              '';
            Sound =
              lib.mkDefaultEnabledOption
              ''
                Apple menu > System Preferences > Control Center > Sound
                Show a sound control in menu bar . Default is null.
                18 = Display icon in menu bar 24 = Hide icon in menu bar.
              '';
          };

          finder = {
            _FXShowPosixPathInTitle =
              lib.mkEnableOption
              ''
                Whether to show the full POSIX filepath in the window title
              '';
            _FXSortFoldersFirst =
              lib.mkDefaultEnabledOption
              ''
                Keep folders on top when sorting by name
              '';
            AppleShowAllExtensions =
              lib.mkDefaultEnabledOption
              ''
                Whether to always show file extensions
              '';
            AppleShowAllFiles =
              lib.mkEnableOption
              ''
                Whether to always show hidden files
              '';
            CreateDesktop =
              lib.mkEnableOption
              ''
                Whether to show icons on the desktop or not
              '';
            _FXSortFoldersFirstOnDesktop =
              lib.mkEnableOption
              ''
                Keep folders on top when sorting by name on the desktop
              '';

            FXEnableExtensionChangeWarning =
              lib.mkDefaultEnabledOption
              ''
                Whether to show warnings when change the file extension of files
              '';
            FXPreferredViewStyle = lib.mkOption {
              type =
                lib.types.enum [
                ];
              description = ''
                Change the default finder view.
                * "icnv" = Icon view,
                * "Nlsv" = List view,
                * "clmv" = Column View,
                "Flwv" = Gallery View
              '';
              default = "Nlsv";
            };
            FXRemoveOldTrashItems =
              lib.mkEnableOption
              ''
                Remove items in the trash after 30 days
              '';
            NewWindowTarget = lib.mkOption {
              type = lib.types.enum [
                "Computer"
                "OS volume"
                "Home"
                "Desktop"
                "Documents"
                "Recents"
                "iCloud Drive"
              ];
              description = ''
                Change the default folder shown in Finder windows.
              '';
              default = "Home";
            };
            QuitMenuItem =
              lib.mkEnableOption
              ''
                Whether to allow quitting of the Finder
              '';
            ShowExternalHardDrivesOnDesktop =
              lib.mkEnableOption
              ''
                Whether to show external disks on desktop
              '';
            ShowHardDrivesOnDesktop =
              lib.mkEnableOption
              ''
                Whether to show hard disks on desktop
              '';
            ShowMountedServersOnDesktop =
              lib.mkEnableOption
              ''
                Whether to show connected servers on desktop
              '';
            ShowPathbar =
              lib.mkDefaultEnabledOption
              ''
                Show path breadcrumbs in finder windows
              '';
            ShowRemovableMediaOnDesktop =
              lib.mkEnableOption
              ''
                Whether to show removable media (CDs, DVDs and iPods) on desktop
              '';
            ShowStatusBar =
              lib.mkDefaultEnabledOption
              ''
                Show status bar at bottom of finder windows with item/disk space stats
              '';
          };

          screensaver = {
            askForPasswordDelay = lib.mkOption {
              type = lib.types.int;
              description = ''
                The number of seconds to delay before the password will be
                required to unlock or stop the screen saver (the grace period).
              '';
              default = 30;
            };

            askForPassword =
              lib.mkDefaultEnabledOption
              ''
                If true, the user is prompted for a password when the screen
                saver is unlocked or stopped.
              '';
          };

          SoftwareUpdate = {
            AutomaticallyInstallMacOSUpdates =
              lib.mkDefaultEnabledOption
              ''
                Automatically install Mac OS software updates.
              '';
          };

          spaces = {
            spans-displays =
              lib.mkEnableOption
              ''
                Apple menu > System Preferences > Mission Control
                Displays have separate Spaces (note a logout is required before this setting will take effect).
                false = each physical display has a separate space (Mac default) true = one space spans across all physical displays.
              '';
          };

          trackpad = {
            ActuateDetents =
              lib.mkDefaultEnabledOption
              ''
                Whether to enable haptic feedback
              '';
            ActuationStrength = lib.mkOption {
              type = lib.types.int;
              description = ''
                0 to enable Silent Clicking, 1 to disable
              '';
              default = 1;
            };
            TrackpadFourFingerHorizSwipeGesture = lib.mkOption {
              type = lib.types.int;
              description = ''
                Whether to enable four-finger horizontal swipe gesture: 0 to
                disable, 2 to swipe between full-screen applications.
              '';
              default = 0;
            };
            TrackpadFourFingerPinchGesture = lib.mkOption {
              type = lib.types.int;
              description = ''
                Whether to enable four-finger pinch gesture (spread shows the
                Desktop, pinch shows the Launchpad): 0 to disable, 2 to enable.
              '';
              default = 0;
            };
            TrackpadFourFingerVertSwipeGesture = lib.mkOption {
              type = lib.types.int;
              description = ''
                0 to disable four finger vertical swipe gestures, 2 to enable
                (down for Mission Control, up for App Exposé).
              '';
              default = 0;
            };
            TrackpadMomentumScroll =
              lib.mkDefaultEnabledOption
              ''
                Whether to use inertia when scrolling
              '';
            TrackpadPinch =
              lib.mkDefaultEnabledOption
              ''
                Whether to enable two-finger pinch gesture for zooming in and out
              '';
            TrackpadRightClick =
              lib.mkDefaultEnabledOption
              ''
                Whether to enable trackpad right click (two-finger tap/click)
              '';
            TrackpadRotate =
              lib.mkDefaultEnabledOption
              ''
                Whether to enable two-finger rotation gesture
              '';
            TrackpadThreeFingerDrag =
              lib.mkEnableOption
              ''
                Whether to enable three-finger drag
              '';
            TrackpadThreeFingerHorizSwipeGesture = lib.mkOption {
              type = lib.types.int;
              description = ''
                Whether to enable three-finger horizontal swipe gesture: 0 to
                disable, 1 to swipe between pages, 2 to swipe between
                full-screen applications.
              '';
              default = 0;
            };
            TrackpadThreeFingerTapGesture = lib.mkOption {
              type = lib.types.int;
              description = ''
                Whether to enable three-finger tap gesture: 0 to disable, 2 to
                trigger Look up & data detectors. The default is 2.
              '';
              default = 0;
            };
            TrackpadThreeFingerVertSwipeGesture = lib.mkOption {
              type = lib.types.int;
              description = ''
                Whether to enable three-finger vertical swipe gesture (down for
                Mission Control, up for App Exposé): 0 to disable, 2 to enable.
              '';
              default = 0;
            };
            TrackpadTwoFingerDoubleTapGesture =
              lib.mkEnableOption
              ''
                Whether to enable smart zoom when double-tapping with two
                fingers. The default is false.
              '';
            TrackpadTwoFingerFromRightEdgeSwipeGesture = lib.mkOption {
              type = lib.types.int;
              description = ''
                Whether to enable two-finger swipe-from-right-edge gesture: 0 to
                disable, 3 to open Notification Center.
              '';
              default = 0;
            };
          };

          universalaccess = {
            reduceMotion =
              lib.mkDefaultEnabledOption
              ''
                Disable animation when switching screens or opening apps.
              '';
            reduceTransparency =
              lib.mkEnableOption
              ''
                Disable transparency in the menu bar and elsewhere.
              '';
          };

          NSGlobalDomain = {
            "com.apple.sound.beep.feedback" = lib.mkOption {
              type = lib.types.int;
              description = ''
                Apple menu > System Preferences > SoundMake a feedback sound
                when the system volume changed
              '';
              default = 0;
            };
            "com.apple.swipescrolldirection" =
              lib.mkEnableOption
              ''Whether to enable "Natural" scrolling direction'';
            "com.apple.trackpad.scaling" = lib.mkOption {
              type = lib.types.int;
              description = ''Configures the trackpad tracking speed (0 to 3)'';
              default = 2;
            };
            _HIHideMenuBar =
              lib.mkDefaultEnabledOption
              ''Whether to autohide the menu bar'';
            AppleEnableMouseSwipeNavigateWithScrolls =
              lib.mkDefaultEnabledOption
              ''
                Enables swiping left or right with two fingers to navigate
                backward or forward
              '';
            AppleEnableSwipeNavigateWithScrolls =
              lib.mkDefaultEnabledOption
              ''
                Enables swiping left or right with two fingers to navigate
                backward or forward
              '';
            AppleInterfaceStyle = lib.mkOption {
              type = lib.types.nullOr (lib.types.enum ["Dark"]);
              description = ''
                Set to 'Dark' to enable dark mode.

                To set to light mode, set this to `null` and you'll need to manually run
                {command}`defaults delete -g AppleInterfaceStyle`.

                This option requires logging out and logging back in to apply.
              '';
              default = "Dark";
            };
            AppleInterfaceStyleSwitchesAutomatically =
              lib.mkEnableOption
              ''Whether to automatically switch between light and dark mode'';
            AppleScrollerPagingBehavior =
              lib.mkDefaultEnabledOption
              ''Jump to the spot that's clicked on the scroll bar'';
            AppleShowAllExtensions =
              lib.mkDefaultEnabledOption
              ''Whether to show all file extensions in Finder'';
            AppleShowAllFiles =
              lib.mkEnableOption
              ''Whether to always show hidden files'';
            AppleShowScrollBars = lib.mkOption {
              type = lib.types.enum [
                "WhenScrolling"
                "Automatic"
                "Always"
              ];
              description = ''
                When to show the scrollbars. Options are 'WhenScrolling',
                'Automatic' and 'Always'.
              '';
              default = "WhenScrolling";
            };
            NSAutomaticWindowAnimationsEnabled =
              lib.mkEnableOption
              ''Whether to animate opening and closing of windows and popovers'';
            NSDisableAutomaticTermination =
              lib.mkEnableOption
              ''Whether to disable the automatic termination of inactive apps'';
            NSDocumentSaveNewDocumentsToCloud =
              lib.mkEnableOption
              ''Whether to save new documents to iCloud by default'';
            NSNavPanelExpandedStateForSaveMode =
              lib.mkDefaultEnabledOption
              ''Whether to use expanded save panel by default'';
            NSNavPanelExpandedStateForSaveMode2 =
              lib.mkDefaultEnabledOption
              ''Whether to use expanded save panel by default'';
            NSTableViewDefaultSizeMode = lib.mkOption {
              type = lib.types.int;
              description = ''
                Sets the size of the finder sidebar icons: 1 (small), 2 (medium)
                or 3 (large)
              '';
              default = 2;
            };
            PMPrintingExpandedStateForPrint =
              lib.mkDefaultEnabledOption
              ''Whether to use the expanded print panel by default'';
            PMPrintingExpandedStateForPrint2 =
              lib.mkDefaultEnabledOption
              ''Whether to use the expanded print panel by default'';
          };
        };
      };
    };
  };
}
