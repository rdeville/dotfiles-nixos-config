{
  config,
  lib,
  ...
}: let
  name = builtins.baseNameOf ../.;
  subname = builtins.baseNameOf ./.;
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
}
