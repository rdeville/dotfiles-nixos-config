{
  inputs,
  hostname,
  mkLib,
  accountsLib,
  ...
}: let
  default = import ../default.nix;

  defaultHostCfg = import ./default.hostCfg.nix {inherit hostname;};

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
  inherit (defaultHostCfg) hostname system;
  inherit flavors presets;

  users = builtins.listToAttrs (
    builtins.map (username: {
      name = username;
      value = import ./${username} {
        inherit inputs accountsLib hostname username;
      };
    })
    (mkLib.mkListDirs ./.)
  );
}
