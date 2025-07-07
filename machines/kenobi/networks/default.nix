# Sources :
# https://labs.quansight.org/blog/2020/07/nixos-rpi-wifi-router
# https://www.jjpdev.com/posts/home-router-nixos/
{...}: {
  imports = [
    ./wan
    ./tun-illyse
    ./eth-public
    ./eth-k8s-switch
    ./wl-public
    ./vlan-k8s-stg
    ./vlan-k8s-prd
    ./wg-public
    ./wg-private
    ./wg-k8s-dev
    ./wg-k8s-stg
    ./wg-k8s-prd
  ];

  boot = {
    kernel = {
      sysctl = {
        # if you use ipv4, this is all you need
        "net.ipv4.conf.all.forwarding" = true;
      };
    };
  };

  systemd = {
    network = {
      enable = true;
    };
  };

  networking = {
    nameservers = [
      # Itself to all local resolving
      "127.0.0.1"
    ];

    firewall = {
      enable = true;
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
