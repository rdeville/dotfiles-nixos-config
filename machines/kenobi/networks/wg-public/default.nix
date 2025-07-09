{
  config,
  lib,
  ...
}: let
  network = "wg-public";
  desc = "Wireguard Public";
  prefix = "172.17.0";
  length = "24";
  listenPort = 60001;
  externalInterface = "tun-illyse";
  clr = "#c27aff";
  cidr = "${prefix}.0/${length}";
in {
  sops = {
    secrets = {
      "network/${network}/private-key" = {
        sopsFile = ./${network}.private.key.enc.txt;
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
        ${network} = {
          netdevConfig = {
            Kind = "wireguard";
            Name = network;
          };
          wireguardConfig = {
            ListenPort = listenPort;
            PrivateKeyFile = config.sops.secrets."network/${network}/private-key".path;
          };
          wireguardPeers = builtins.map (
            peer: {
              inherit (peer) AllowedIPs PublicKey;
              PersistentKeepalive = 25;
            }
          ) (import ./peers.nix {inherit lib;});
        };
      };

      networks = {
        ${network} = {
          matchConfig = {
            Name = network;
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
    wireguard = {
      enable = true;
    };

    firewall = {
      interfaces = {
        ${externalInterface} = {
          allowedUDPPorts = [
            listenPort # Wireguard
          ];
        };
        ${network} = {
          allowedTCPPorts = [
            53 # DNS
          ];
          allowedUDPPorts = [
            53 # DNS
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
      ${network} = {
        name = desc;
        cidrv4 = cidr;
        style = {
          primaryColor = clr;
          secondaryColor = null;
          pattern = "dotted";
        };
      };
    };

    self = {
      interfaces = {
        ${network} = {
          inherit network;
        };
      };
      services = {
        ${network} = {
          icon = "services.wireguard";
          name = desc;
        };
      };
    };
  };
}
