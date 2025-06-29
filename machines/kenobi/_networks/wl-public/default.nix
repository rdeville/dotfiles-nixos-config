{config, ...}: let
  id = 2;
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

  systemd = {
    network = {
      networks = {
        "200${toString id}-${wlanIface}" = {
          enable = true;
          matchConfig = {
            Name = wlanIface;
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
    firewall = {
      interfaces = {
        "${wlanIface}" = {
          allowedTCPPorts = [
            # SSH Port
            22
            # DNS Port
            53
          ];
          allowedUDPPorts = [
            # DHCP Port
            67
            # DNS Port
            53
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
                {
                  hw-address = "10:bf:48:7c:c8:e6";
                  hostname = "darth-maul";
                  ip-address = "${prefix}.30";
                }
                {
                  hw-address = "74:13:ea:be:97:9a";
                  hostname = "rey";
                  ip-address = "${prefix}.20";
                }
              ];
              pools = [
                {
                  pool = "${prefix}.64 - ${prefix}.254";
                }
              ];
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

  topology = {
    networks = {
      wl-public = {
        name = "Public Wireless Network";
        cidrv4 = "172.16.2.1/24";
        style = {
          primaryColor = "#05df72";
          secondaryColor = null;
          pattern = "solid";
        };
      };
    };
    self = {
      interfaces = {
        wlp5s0f0 = {
          network = "wl-public";
        };
      };
    };
  };
}
