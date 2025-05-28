{...}: {
  imports = [
    ./tun-illyse
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
    # WAN default Interface
    interfaces = {
      enp1s0 = {
        useDHCP = true;
      };
    };

    nat = {
      enable = false;
    };

    firewall = {
      enable = true;
      interfaces = {
        "enp1s0" = {
          allowedTCPPorts = [
            # SSH Port
            22
          ];
        };
      };
    };

    nftables = {
      enable = true;
      ruleset = builtins.readFile ./config.nftables;
    };
  };

  services = {
    openssh = {
      openFirewall = false;
    };

    kea = {
      dhcp4 = {
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
