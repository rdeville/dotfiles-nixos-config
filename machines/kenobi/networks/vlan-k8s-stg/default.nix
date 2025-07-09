{...}: let
  network = "k8s-stg";
  desc = "Vlan k8s stg";
  prefix = "172.16.144";
  length = "24";

  # Tailwing Yellow 500
  clr = "#f0b100";
  cidr = "${prefix}.0/${length}";

  vlanId = 144;
  lanDevices = [
    "enp3s0"
  ];
in {
  systemd = {
    network = {
      netdevs = {
        # '10-' prefix is important here to avoid concurrency conflict.
        "10-${network}" = {
          netdevConfig = {
            Kind = "vlan";
            Name = network;
          };
          vlanConfig = {
            Id = vlanId;
          };
        };
      };

      networks =
        {
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
        }
        // (builtins.foldl' (acc: elem:
          {
            ${elem} = {
              enable = true;
              matchConfig = {
                Name = elem;
              };
              vlan = [
                network
              ];
              linkConfig = {
                RequiredForOnline = "no";
              };
            };
          }
          // acc) {}
        lanDevices);
    };
  };

  networking = {
    firewall = {
      interfaces = {
        "${network}" = {
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
              id = vlanId;
              subnet = "${prefix}.0/${length}";
              reservations = [
                # {
                #   hw-address = "10:bf:48:7c:c8:e6";
                #   hostname = "darth-maul";
                #   ip-address = "${vlan.lan.prefix}.10";
                # }
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
          icon = ../../../../assets/images/interfaces/vlan.png;
          virtual = true;
        };
      };
    };
  };
}
