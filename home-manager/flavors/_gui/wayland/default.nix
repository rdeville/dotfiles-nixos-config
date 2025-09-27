{
  config,
  lib,
  pkgs,
  ...
}: let
  name = builtins.baseNameOf ../.;
  subname = builtins.baseNameOf ./.;
  cfg = config.hm.flavors.${name}.${subname};
in {
  imports = [
    ./hyprland
    ./hyprlock
    ./hyprspace
    ./swww
    ./waybar
    ./wl-kbptr
  ];

  options = {
    hm = {
      flavors = {
        ${name} = {
          ${subname} = {
            enable =
              lib.mkDependEnabledOption ''
                Install ${name}.${subname} Home-Manager flavor.
              ''
              (! config.hm.isDarwin && config.hm.flavors.${name}.enable);
          };
        };
      };
    };
  };

  config = lib.mkIf cfg.enable {
    xdg = {
      portal = {
        enable = true;
        extraPortals = with pkgs; [
          xdg-desktop-portal-wlr
          xdg-desktop-portal-gtk
        ];
      };
    };
  };
}
