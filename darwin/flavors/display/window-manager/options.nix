{
  lib,
  config,
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

            AppWindowGroupingBehavior =
              lib.mkEnableOption
              ''
                Grouping strategy when showing windows from an application. false
                means "One at a time" true means "All at once"
              '';
            AutoHide =
              lib.mkEnableOption
              ''Auto hide stage strip showing recent apps '';
            EnableStandardClickToShowDesktop =
              lib.mkDefaultEnabledOption
              ''
                Click wallpaper to reveal desktop Clicking your wallpaper will
                move all windows out of the way to allow access to your desktop
                items and widgets. Default is true. false means "Only in Stage
                Manager" true means "Always"
              '';
            EnableTiledWindowMargins =
              lib.mkDefaultEnabledOption
              ''Enable window margins when tiling windows '';
            EnableTilingByEdgeDrag =
              lib.mkDefaultEnabledOption
              ''Enable dragging windows to screen edges to tile them '';
            EnableTilingOptionAccelerator =
              lib.mkEnableOption
              ''Enable holding alt to tile windows '';
            EnableTopTilingByEdgeDrag =
              lib.mkDefaultEnabledOption
              ''Enable dragging windows to the menu bar to fill the screen '';
            GloballyEnabled =
              lib.mkEnableOption
              ''
                Enable Stage Manager. Stage Manager arranges your recent windows
                into a single strip for reduced clutter and quick access.
              '';
            HideDesktop =
              lib.mkDefaultEnabledOption
              ''Hide items in Stage Manager '';
            StageManagerHideWidgets =
              lib.mkDefaultEnabledOption
              ''Hide widgets in Stage Manager '';
            StandardHideDesktopIcons =
              lib.mkDefaultEnabledOption
              ''Hide items on desktop '';
            StandardHideWidgets =
              lib.mkDefaultEnabledOption
              ''Hide widgets on desktop '';
          };
        };
      };
    };
  };
}
