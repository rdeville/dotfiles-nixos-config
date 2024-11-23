{
  inputs,
  accountsLib,
  hostname,
  mkLib,
  ...
}: let
  default = import ../default.nix {
    inherit inputs accountsLib system hostname;
  };

  system = "x86_64-linux";

  flavors =
    default.osFlavors
    // {
      ssh.enable = true;
      steam.enable = true;
    };

  presets =
    default.osPresets
    // {
      main = {
        enable = false;
      };

      gui = {
        enable = true;
        displayManager = {
          gdm.enable = true;
        };
        windowManager = {
          awesome = {
            enable = true;
          };
          hyprland = {
            enable = true;
          };
        };
      };
    };
in {
  inherit (default) editor terminal keyMap stateVersion;
  inherit hostname system flavors presets;

  users = default.mkNixosUser (mkLib.mkListDirs ./.);
}
