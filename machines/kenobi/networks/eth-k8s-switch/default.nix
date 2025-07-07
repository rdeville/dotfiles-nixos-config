{...}: let
  id = 3;
  network = "enp3s0";
  prefix = "172.16.3";
  length = "24";
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
              inherit id;
              subnet = "${prefix}.0/${length}";
              reservations = [
                {
                  hw-address = "8c:90:2d:9d:20:16";
                  hostname = "k8s-switch";
                  ip-address = "${prefix}.100";
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
}
