{
  config,
  lib,
  ...
}: let
  prefix = "172.30.160";
  length = "24";
  network = "wg-k8s-dev";
  serverEndpoint = "89.234.140.170:65160";
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
            "${prefix}.203/24"
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
      interfaces = {
        ${network} = {
          allowedTCPPorts = [
            # Cilium Port
            # See: https://docs.cilium.io/en/stable/operations/system_requirements/
            4240 # Cilium health
            10250 # Cilium metrics
            9965 # Hubble metrics
            4244 # Hubble peer
          ];
          allowedUDPPorts = [
            # Cilium Port
            # See: https://docs.cilium.io/en/stable/operations/system_requirements/
            51871 # Wireguard
          ];
        };
      };
    };

    nftables = {
      ruleset = builtins.readFile ./config.nftables;
    };
  };
}
