# Source :
# https://labs.quansight.org/blog/2020/07/nixos-rpi-wifi-router
{config, ...}: let
  id = 2;
  wlanDevice = "wlp5s0f0";
  wlanIface = "wlp5s0f0";
  prefix = "172.16.${toString id}";
  length = 24;
in {
  sops = {
    secrets = {
      "wireless/public/password" = {
        sopsFile = ../../secrets.enc.yaml;
      };
    };
  };

  networking = {
    # Physical and virtual Interface
    wlanInterfaces = {
      ${wlanIface} = {
        device = wlanDevice;
      };
    };

    interfaces = {
      ${wlanIface} = {
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

    firewall = {
      interfaces = {
        "${wlanIface}" = {
          allowedUDPPorts = [
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
    # Entropy source
    haveged = {
      enable = true;
    };

    hostapd = {
      enable = true;
      radios = {
        ${wlanIface} = {
          band = "2g";
          countryCode = "FR";
          # French channels are 1, 6 and 11
          channel = 1;
          networks = {
            ${wlanIface} = {
              logLevel = 2; # default 2
              authentication = {
                mode = "wpa2-sha256";
                wpaPasswordFile = config.sops.secrets."wireless/public/password".path;
              };
              ssid = "La Resistance";
            };
          };
        };
      };
    };

    kea = {
      dhcp4 = {
        enable = true;
        settings = {
          interfaces-config = {
            interfaces = [
              wlanIface
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
              interface = wlanIface;
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
