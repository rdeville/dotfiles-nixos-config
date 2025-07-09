{...}: let
  id = 1;
  network = "enp2s0";
  desc = "Public Ethernet Network";
  prefix = "172.16.0";
  length = "24";
  clr = "#00a63e";
  cidr = "${prefix}.0/${length}";
in {
  systemd = {
    network = {
      networks = {
        ${network} = {
          enable = true;
          matchConfig = {
            Name = network;
          };
          networkConfig = {
            DHCP = "no";
            IPv6AcceptRA = false;
          };
          address = [
            "${prefix}.1/${length}"
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
        ${network} = {
          allowedTCPPorts = [
            53 # DNS
          ];
          allowedUDPPorts = [
            53 # DNS
            67 # DHCP
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
              network
            ];
          };
          subnet4 = [
            {
              inherit id;
              subnet = cidr;
              reservations = [
                {
                  hw-address = "74:13:ea:be:97:9a";
                  hostname = "rey";
                  ip-address = "${prefix}.3";
                }
              ];
              pools = [
                {
                  pool = "${prefix}.64 - ${prefix}.254";
                }
              ];
              interface = network;
              option-data = [
                {
                  name = "routers";
                  data = "${prefix}.1";
                }
                {
                  name = "domain-name-servers";
                  data = "${prefix}.1";
                }
              ];
            }
          ];
        };
      };
    };
  };

  topology = {
    networks = {
      ${network} = {
        name = desc;
        cidrv4 = cidr;
        style = {
          primaryColor = clr;
          secondaryColor = null;
          pattern = "solid";
        };
      };
    };
    self = {
      interfaces = {
        ${network} = {
          inherit network;
        };
      };
    };
  };
}
