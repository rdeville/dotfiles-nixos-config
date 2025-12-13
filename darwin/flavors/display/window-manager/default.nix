{
  config,
  lib,
  ...
}: let
  name = builtins.baseNameOf ../.;
  subname = builtins.baseNameOf ./.;
  cfg = config.os.flavors.${name}.${subname};
in {
  imports = [
    ./options.nix
  ];

  config = lib.mkIf cfg.enable {
    system = {
      defaults = {
        WindowManager = {
          inherit
            (cfg)
            AppWindowGroupingBehavior
            AutoHide
            EnableStandardClickToShowDesktop
            EnableTiledWindowMargins
            EnableTilingByEdgeDrag
            EnableTilingOptionAccelerator
            EnableTopTilingByEdgeDrag
            GloballyEnabled
            HideDesktop
            StageManagerHideWidgets
            StandardHideDesktopIcons
            StandardHideWidgets
            ;
        };
      };
    };
  };
}
