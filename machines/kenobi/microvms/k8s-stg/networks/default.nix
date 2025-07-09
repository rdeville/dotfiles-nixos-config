{...}: {
  imports = [
    ./eth
    ./wg-k8s-stg
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
