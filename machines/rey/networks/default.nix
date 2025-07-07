{...}: {
  imports = [
    ./wg-k8s-dev
    ./wg-k8s-stg
    ./wg-k8s-prd
    ./wg-private
    ./wg-public
    ./wlp170s0
  ];

  networking = {
    firewall = {
      enable = true;
      allowPing = true;
    };

    networkmanager = {
      enable = true;
    };

    nftables = {
      enable = true;
      ruleset = builtins.readFile ./config.nftables;
    };
  };
}
