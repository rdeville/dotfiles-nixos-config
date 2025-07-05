{
  config,
  lib,
  ...
}: let
  id = 1;
  wgDevice = "wg-public";
  wgIface = "wg-public";
  prefix = "172.17.${toString id}";
  length = 24;

  listenPort = 65142;

  mkLib = config.lib.topology;
in {
  sops = {
    secrets = {
      "wg-public/private-key" = {
        sopsFile = ./wg-public.private.key.enc.txt;
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
        "300${toString id}-${wgIface}" = {
          netdevConfig = {
            Kind = "wireguard";
            Name = wgDevice;
          };
          wireguardConfig = {
            ListenPort = listenPort;
            PrivateKeyFile = config.sops.secrets."wg-public/private-key".path;
          };
          wireguardPeers = builtins.map (
            peer: {
              AllowedIPs = [
                "0.0.0.0/0"
              ];
              PublicKey = peer.pubKey;
              PersistentKeepalive = 25;
            }
          ) (import ./peers.nix {inherit lib;});
        };
      };

      networks = {
        "300${toString id}-${wgIface}" = {
          matchConfig = {
            Name = wgDevice;
          };
          # networkConfig = {
          #   IPMasquerade = "ipv4";
          #   IPv4Forwarding = true;
          # };
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
            # Wireguard ports open on all interface
            listenPort
          ];
        };
        "${wgIface}" = {
          allowedTCPPorts = [
            # DNS Port
            53
            # HTTP(s) Ports
            80
            443
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

  topology = {
    networks = {
      wg-public = {
        name = "Wireguard Public";
        cidrv4 = "172.17.1.0/24";
        style = {
          primaryColor = "#c27aff";
          secondaryColor = null;
          pattern = "dotted";
        };
      };
    };
    self = {
      interfaces = {
        wg-public = {
          network = "wg-public";
        };
      };

      services = {
        wireguard-public = {
          icon = "services.wireguard";
          name = "WireGuard Public VPN";
        };
      };
    };
  };
}
