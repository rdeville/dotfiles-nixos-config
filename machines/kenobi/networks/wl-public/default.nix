{config, ...}: let
  id = 2;
  network = "wl-public";
  interface = "wlp5s0f0";
  prefix = "172.16.2";
  length = "24";
  clr = "#05df72";
  cidr = "${prefix}.0/${length}";
in {
  sops = {
    secrets = {
      "network/${network}/password" = {
        sopsFile = ../../secrets.enc.yaml;
      };
    };
  };

  os = {
    flavors = {
      network = {
        networks = {
          ${network} = {
            inherit interface;
            isServer = true;
            activationPolicy = "up";
            requiredForOnline = "no";
            networkCIDRPrefix = prefix;
            networkCIDRLength = length;
            address = [
              "${prefix}.1/${length}"
            ];
            allowedTCPPorts = [
              53 # DNS
            ];
            allowedUDPPorts = [
              53 # DNS
              67 # DHCP
            ];
            nftables = {
              tunInterfaces = [
                "wg-tun-illyse"
              ];
            };
            topology = {
              color = clr;
              desc = "Local Wireless";
            };
          };
        };
      };
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
        ${network} = {
          band = "2g";
          countryCode = "FR";
          # French channels are 1, 6 and 11
          channel = 1;
          networks = {
            ${network} = {
              logLevel = 2; # default 2
              authentication = {
                mode = "wpa2-sha256";
                wpaPasswordFile = config.sops.secrets."network/${network}/password".path;
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
}
