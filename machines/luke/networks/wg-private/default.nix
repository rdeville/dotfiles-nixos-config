{
  config,
  lib,
  ...
}: let
  prefix = "172.18.144";
  length = "24";
  network = "wg-private";
  serverEndpoint = "172.16.144.1:61000";
  activationPolicy = "up";
  cidr = "${prefix}.0/${length}";
  allowedIPs = [cidr];
  secretPath = "network/${network}/private-key";
in {
  sops = {
    secrets = {
      ${secretPath} = {
        sopsFile = ../../_keys/${network}.private.key.enc.txt;
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
          enable = true;
          netdevConfig = {
            Kind = "wireguard";
            Name = network;
          };
          wireguardConfig = {
            PrivateKeyFile = config.sops.secrets."${secretPath}".path;
          };
          wireguardPeers = [
            {
              PublicKey = lib.removeSuffix "\n" (
                builtins.readFile ../../../../../kenobi/networks/${network}/${network}.pub
              );
              AllowedIPs = allowedIPs;
              Endpoint = serverEndpoint;
            }
          ];
        };
      };

      networks = {
        ${network} = {
          matchConfig = {
            Name = network;
          };
          address = [
            "${prefix}.11/24"
          ];
          dns = [
            "${prefix}.1"
          ];
          routes = [
            {
              Destination = cidr;
            }
          ];
          networkConfig = {
            IPv6AcceptRA = false;
          };
          DHCP = "no";
          linkConfig = {
            # Kube API access network, down by default, use command to activate:
            # `sudo ip link set ${network} up`
            ActivationPolicy = activationPolicy;
            RequiredForOnline = "no";
          };
        };
      };
    };
  };

  networking = {
    firewall = {
      enable = true;
      interfaces = {
        ${network} = {
          allowedTCPPorts = [
            22 # SSH
          ];
          allowedUDPPorts = [];
        };
      };
    };

    nftables = {
      enable = true;
      ruleset = builtins.readFile ./config.nftables;
    };
  };
}
