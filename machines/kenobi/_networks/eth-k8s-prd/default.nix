{config, ...}: let
  id = 128;
  lanDevice = "enp3s0";
  lanIface = "k8s-prd";
  prefix = "172.16.${toString id}";
  length = 20;

  mkLib = config.lib.topology;
in {
  systemd = {
    network = {
      netdevs = {
        "2${toString id}-${lanIface}" = {
          netdevConfig = {
            Kind = "vlan";
            Name = "${lanIface}";
          };
          vlanConfig = {
            Id = id;
          };
        };
      };

      networks = {
        "${lanDevice}" = {
          enable = false;
          matchConfig = {
            Name = lanDevice;
          };
          vlan = [
            lanIface
          ];
          linkConfig = {
            RequiredForOnline = "no";
          };
        };
        "${lanIface}" = {
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
          linkConfig = {
            RequiredForOnline = "no";
          };
        };
      };
    };
  };

  networking = {
    # firewall = {
    #   interfaces = {
    #     "${lanIface}" = {
    #       allowedUDPPorts = [
    #         # DNS Port
    #         53
    #         # DHCP Port
    #         67
    #       ];
    #     };
    #   };
    # };

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

  topology = {
    networks = {
      k8s-prd = {
        name = "Kubernetes Production Network";
        cidrv4 = "172.16.128.1/24";
        style = {
          primaryColor = "#155dfc";
          secondaryColor = null;
          pattern = "solid";
        };
      };
    };
    self = {
      interfaces = {
        k8s-prd = {
          virtual = true;
          network = "k8s-prd";
        };
      };
    };
  };
}
