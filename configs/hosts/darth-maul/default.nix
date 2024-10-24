{
  inputs,
  hostName,
  mkLib,
  accountsLib,
  ...
}: let
  system = "x86_64-linux";
  stateVersion = "24.05";

  userCfg = inode: {
    inherit system stateVersion;
    username = inode;
    hostname = hostName;
  };
in {
  inherit system stateVersion;

  editor = "nvim";
  terminal = "kitty";
  keyMap = "fr";

  users = builtins.listToAttrs (
    builtins.map (inode: {
      name = inode;
      value = import ./${inode} {
        userCfg = userCfg inode;
        inherit inputs mkLib accountsLib;
      };
    })
    (mkLib.mkListDirs ./.)
  );

  flavors = {
    ssh.enable = true;
    steam.enable = true;
  };

  presets = {
    minimal = {
      enable = true;
    };

    main = {
      enable = false;
    };

    gui = {
      enable = true;
      displayManager = {
        gdm.enable = true;
      };
      windowManager = {
        awesome = {};
        hyprland = {};
      };
    };
  };

  inherit hostName;
}
