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
              name = peer;
              allowedIPs = [
                "${prefix}.64/25"
              ];
              publicKey = builtins.readFile ./peers/${peer};
            }
          ) (lib.listDirs ./peers);
        };
      };

      networks = {
        "300${toString id}-${wgIface}" = {
          matchConfig = {
            Name = wgDevice;
          };
          networkConfig = {
            IPMasquerade = "ipv4";
            IPv4Forwarding = true;
          };
          address = [
            "${prefix}.1/${toString length}"
          ];
        };
      };
    };
  };

  networking = {
    firewall = {
      interfaces = {
        "${wgIface}" = {
          allowedTCPPorts = [
            # SSH Port
            22
            # DNS Port
            53
          ];
          allowedUDPPorts = [
            # Wireguard ports
            listenPort
            # DHCP Port
            67
            # DNS Port
            53
          ];
        };
      };
    };

    # nftables = {
    #   ruleset = builtins.readFile ./config.nftables;
    # };
  };
}
