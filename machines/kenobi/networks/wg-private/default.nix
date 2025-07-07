{
  config,
  lib,
  ...
}: let
  network = "wg-private";
  desc = "Wireguard Private";
  prefix = "172.18.0";
  length = "16";
  listenPort = 61001;
  externalInterface = "tun-illyse";
  clr = "#fb2c36";
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
            22 # SSH
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
