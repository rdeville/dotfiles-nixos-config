{...}: {
  os = {
    hostname = "rey";
    system = "x86_64-linux";
    isGui = true;
    isMain = true;

    users = {
      rdeville = {
        isSudo = true;
      };
      root = {};
    };

    flavors = {
      display-manager = {
        enable = true;
        ly = {
          enable = true;
        };
      };
      window-manager = {
        enable = true;
        awesome = {
          enable = true;
        };
        hyprland = {
          enable = true;
        };
      };
      k3s = {
        enable = false;
      };
      printing = {
        enable = false;
      };
      ssh-server = {
        enable = true;
      };
      steam = {
        enable = true;
      };
    };
  };
}
