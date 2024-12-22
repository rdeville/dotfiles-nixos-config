{...}: {
  os = {
    hostname = "darth-plagueis";
    system = "x86_64-linux";
    isGui = false;
    isMain = false;

    # TODO: Update below
    # users = default.mkNixosUser (mkLib.mkListDirs ./.);
    users = {
      rdeville = {
        isSudo = true;
      };
      root = {};
    };

    flavors = {
      k3s = {
        enable = true;
      };
      ssh-server = {
        enable = true;
      };
    };
  };
}
