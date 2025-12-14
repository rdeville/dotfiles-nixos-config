{lib, ...}: let
  name = builtins.baseNameOf ./.;
in {
  options = {
    os = {
      flavors = {
        ${name} = {
          enable = lib.mkDefaultEnabledOption "Install ${name} Darwin flavors.";
        };
      };
    };
  };

  imports = [
    ./dock
    ./window-manager
  ];
}
