{...}: let
  id = 1;
  lanIface = "enp2s0";
  prefix = "172.16.${toString id}";
  length = 24;
in {
  systemd = {
    network = {
      networks = {
        "200${toString id}-${lanIface}" = {
          enable = true;
          matchConfig = {
            Name = lanIface;
          };
          networkConfig = {
            DHCP = "no";
            IPv6AcceptRA = false;
          };
          address = [
            "${prefix}.1/${toString length}"
          ];
          routes = [
            {
              Destination = "${prefix}.0/${toString length}";
              Gateway = "${prefix}.1";
              Source = "192.168.1.0/24";
            }
          ];
          linkConfig = {
            RequiredForOnline = "no";
          };
        };
      };
    };
  };
  networking = {
    firewall = {
      interfaces = {
        "${lanIface}" = {
          allowedTCPPorts = [
            # SSH Port
            22
          ];
          allowedUDPPorts = [
            # DNS Port
            53
            # DHCP Port
            67
          ];
        };
      };
    };

    nftables = {
      ruleset = builtins.readFile ./config.nftables;
    };
  };

  services = {
    kea = {
      dhcp4 = {
        enable = true;
        settings = {
          interfaces-config = {
            interfaces = [
              lanIface
            ];
          };
          subnet4 = [
            {
              inherit id;
              subnet = "${prefix}.0/${toString length}";
              reservations = [
                # {
                #   hw-address = "10:bf:48:7c:c8:e6";
                #   hostname = "darth-maul";
                #   ip-address = "${vlan.lan.prefix}.10";
                # }
              ];
              pools = [{pool = "${prefix}.64 - ${prefix}.254";}];
              interface = lanIface;
              option-data = [
                {
                  name = "routers";
                  data = "${prefix}.1";
                }
                # {
                #   name = "domain-name-servers";
                #     data = "${prefix}.1";
                # }
              ];
            }
          ];
        };
      };
    };
  };
}
