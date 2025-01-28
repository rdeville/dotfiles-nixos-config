{...}: {
  os = {
    hostName = "darth-plagueis";
    system = "x86_64-linux";
    isGui = false;
    isMain = false;

    users = {
      rdeville = {
        isSudo = true;
      };
      root = {};
    };

    flavors = {
      _core = {
        nix-ld = {
          enable = true;
        };
      };
      ssh-server = {
        enable = true;
      };
    };
  };
}
