{pkgs, ...}: {
  services = {
    libinput = {
      enable = true;
    };

    displayManager = {
      defaultSession = "none+awesome";
    };
    # X Server
    xserver = {
      enable = true;

      xkb = {
        layout = "fr";
      };

      displayManager = {
        lightdm = {
          enable = true;
          greeters.slick.enable = true;
        };
      };

      windowManager = {
        awesome = {
          enable = true;
          luaModules = with pkgs.luaPackages; [
            # The package manager for Lua modules
            luarocks
          ];
        };
      };
    };
  };
}
