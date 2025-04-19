{...}: {
  imports = [
    ./wan
    ./wl-public
    ./eth-public
    ./eth-k8s-prd
    ./eth-k8s-stg
  ];

  boot = {
    kernel = {
      sysctl = {
        # if you use ipv4, this is all you need
        "net.ipv4.conf.all.forwarding" = true;
      };
    };
  };

  networking = {
    nat = {
      enable = false;
    };

    firewall = {
      enable = false;
    };

    nftables = {
      enable = true;
      ruleset = builtins.readFile ./config.nftables;
    };

    interfaces = {
      enp1s0 = {
        useDHCP = true;
      };
    };
  };

  services = {
    kea = {
      dhcp4 = {
        enable = true;
        settings = {
          lease-database = {
            name = "/var/lib/kea/dhcp4.leases";
            persist = true;
            type = "memfile";
          };
          rebind-timer = 2000;
          renew-timer = 1000;
          valid-lifetime = 4000;
        };
      };
    };
  };
}
