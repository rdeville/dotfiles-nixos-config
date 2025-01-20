{lib, ...}: let
  name = builtins.baseNameOf ../.;
  subname = builtins.baseNameOf ./.;
in {
  imports = [
    ./hyprland
    ./hyprlock
    ./hyprswitch
    ./hyprexpo
    ./hyprspace
    ./rofi
    ./waybar
    ./wl-kbptr
  ];

  options = {
    hm = {
      flavors = {
        ${name} = {
          ${subname} = {
            enable = lib.mkDefaultEnabledOption ''
              Install ${name}.${subname} Home-Manager flavor.
            '';
          };
        };
      };
    };
  };
}
