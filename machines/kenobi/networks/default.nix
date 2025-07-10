# Sources :
# https://labs.quansight.org/blog/2020/07/nixos-rpi-wifi-router
# https://www.jjpdev.com/posts/home-router-nixos/
{...}: {
  imports = [
    ./wan
    ./wl-public
    ./wg-tun-illyse
    ./wg-servers
    ./vlan
    ./ethernet
  ];

  boot = {
    kernel = {
      sysctl = {
        # if you use ipv4, this is all you need
        "net.ipv4.conf.all.forwarding" = true;
      };
    };
  };

  os = {
    flavors = {
      network = {
        enable = true;

        firewall = {
          allowPing = true;
        };

        nameservers = [
          # Itself to all local resolving
          "127.0.0.1"
          # FDN
          "80.67.169.12"
          "80.67.169.40"
        ];
      };
    };
  };

  services = {
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
