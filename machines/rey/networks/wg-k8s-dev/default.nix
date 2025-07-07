{
  config,
  lib,
  ...
}: let
  prefix = "172.30.160";
  length = "24";
  network = "wg-k8s-dev";
  serverEndpoint = "89.234.140.170:65160";
  activationPolicy = "down";
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
                builtins.readFile ../../../kenobi/networks/${network}/${network}.pub
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
            "${prefix}.3/24"
          ];
          dns = [
            "${prefix}.1"
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
      interfaces = {
        ${network} = {
          allowedTCPPorts = [];
          allowedUDPPorts = [];
        };
      };
    };

    nftables = {
      ruleset = builtins.readFile ./config.nftables;
    };
  };
}
