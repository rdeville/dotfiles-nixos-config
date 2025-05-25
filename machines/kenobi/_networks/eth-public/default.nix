# Source :
# https://labs.quansight.org/blog/2020/07/nixos-rpi-wifi-router
{...}: let
  id = 1;
  lanDevice = "enp2s0";
  lanIface = lanDevice;
  prefix = "172.16.${toString id}";
  length = 24;
in {
  networking = {
    # Physical and virtual Interface
    interfaces = {
      ${lanIface} = {
        useDHCP = false;
        ipv4 = {
          routes = [
            {
              address = "${prefix}.0";
              prefixLength = length;
              via = "${prefix}.1";
            }
          ];
          addresses = [
            {
              address = "${prefix}.1";
              prefixLength = length;
            }
          ];
        };
      };
    };

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
