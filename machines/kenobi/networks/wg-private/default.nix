{
  config,
  lib,
  ...
}: let
  id = 0;
  wgDevice = "wg-private";
  wgIface = "wg-private";
  prefix = "172.18.${toString id}";
  length = 16;

  listenPort = 65143;
in {
  sops = {
    secrets = {
      "wg-private/private-key" = {
        sopsFile = ./wg-private.private.key.enc.txt;
        format = "binary";
        group = config.users.users.systemd-network.group;
        mode = "0640";
        reloadUnits = [
          "systemd-networkd.service"
        ];
      };
    };
  };

  systemd = {
    network = {
      netdevs = {
        "400${toString id}-${wgIface}" = {
          netdevConfig = {
            Kind = "wireguard";
            Name = wgDevice;
          };
          wireguardConfig = {
            ListenPort = listenPort;
            PrivateKeyFile = config.sops.secrets."wg-private/private-key".path;
          };
          wireguardPeers = builtins.map (
            peer: {
              AllowedIPs = [
                "${prefix}.0/${toString length}"
              ];
              PublicKey = peer.pubKey;
              PersistentKeepalive = 25;
            }
          ) (import ./peers.nix {inherit lib;});
        };
      };

      networks = {
        "400${toString id}-${wgIface}" = {
          matchConfig = {
            Name = wgDevice;
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
    wireguard = {
      enable = true;
    };

    firewall = {
      interfaces = {
        "tun-illyse" = {
          allowedUDPPorts = [
            # Open port on public IP
            listenPort
          ];
        };

        "${wgIface}" = {
          allowedTCPPorts = [
            # SSH Port
            22
            # DNS Port
            53
            # Kube API
            6443
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

  topology = {
    networks = {
      wg-private = {
        name = "Wireguard Private";
        cidrv4 = "${prefix}.0/${toString length}";
        style = {
          primaryColor = "#9810fa";
          secondaryColor = null;
          pattern = "dotted";
        };
      };
    };
    self = {
      interfaces = {
        wg-private = {
          network = "wg-private";
        };
      };

      services = {
        wireguard-private = {
          icon = "services.wireguard";
          name = "WireGuard Private VPN";
        };
      };
    };
  };
}
