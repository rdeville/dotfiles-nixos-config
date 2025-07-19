{...}: {
  imports = [
    ./eth
    ./wg-k8s-dev
  ];

  networking = {
    firewall = {
      enable = true;
    };

    nftables = {
      enable = true;
    };
  };
}
