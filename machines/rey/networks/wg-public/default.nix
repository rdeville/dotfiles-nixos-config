{
  config,
  lib,
  ...
}: let
  prefix = "172.17.0";
  length = "24";
  network = "wg-public";
  serverEndpoint = "89.234.140.170:60001";
  activationPolicy = "down";
  cidr = "${prefix}.0/${length}";
  allowedIPs = ["0.0.0.0/0"];
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
            "${prefix}.3/${length}"
          ];
          dns = [
            "${prefix}.1"
          ];
          gateway = [
            "${prefix}.1"
          ];
          networkConfig = {
            IPv6AcceptRA = false;
          };
          DHCP = "no";
          linkConfig = {
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
      enable = true;
      ruleset = builtins.readFile ./config.nftables;
    };
  };
}
