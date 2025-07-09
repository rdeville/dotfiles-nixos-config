{...}: {
  imports = [
    ./eth
    ./wg-k8s-dev
  ];

  networking = {
    enableIPv6 = false;

    firewall = {
      allowPing = true;
      enable = true;
    };

    nftables = {
      enable = true;
      ruleset = builtins.readFile ./config.nftables;
    };
  };
}
