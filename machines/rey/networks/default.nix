{...}: {
  imports = [
    ./wg-kenobi-pri
    ./wg-kenobi-pub
    ./wlp170s0
  ];

  networking = {
    networkmanager = {
      enable = true;
    };
    wireguard = {
      enable = true;
    };
  };
}
