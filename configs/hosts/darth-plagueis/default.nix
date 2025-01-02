{...}: {
  os = {
    hostname = "darth-plagueis";
    system = "x86_64-linux";
    isGui = false;
    isMain = false;

    users = {
      rdeville = {
        isSudo = true;
      };
      root = {};
    };
  };
}
