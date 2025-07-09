{config, ...}: let
  id = 2;
  network = "wlp5s0f0";
  desc = "Public Wireless Network";
  prefix = "172.16.1";
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
            80 # HTTP
            443 # HTTPs
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
