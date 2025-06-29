{
  config,
  lib,
  ...
}: let
  wgPubIface = "wg-kenobi-pub";
  wgPubPort = 65142;
  wgPubPrefix = "172.17.1";
  wgPubIp = "${wgPubPrefix}.${toString wgPubId}";
  wgPubId = 20;

  wgPriIface = "wg-kenobi-pri";
  wgPriPort = 65143;
  wgPriPrefix = "172.18.1";
  wgPriIp = "${wgPriPrefix}.${toString wgPriId}";
  wgPriId = 20;
in {
  sops = {
    secrets = {
      "wg-kenobi-public/private-key" = {
        sopsFile = ./_keys/wg-public.private.key.enc.txt;
        format = "binary";
        group = config.users.users.systemd-network.group;
        mode = "0640";
        reloadUnits = [
          "systemd-networkd.service"
        ];
      };
    };
    secrets = {
      "wg-kenobi-private/private-key" = {
        sopsFile = ./_keys/wg-private.private.key.enc.txt;
        format = "binary";
        group = config.users.users.systemd-network.group;
        mode = "0640";
        reloadUnits = [
          "systemd-networkd.service"
        ];
      };
    };
  };

  networking = {
    enableIPv6 = false;
    wireguard = {
      enable = true;
    };
  };

  systemd = {
    network = {
      netdevs = {
        "3001-${wgPubIface}" = {
          enable = true;
          netdevConfig = {
            Kind = "wireguard";
            Name = wgPubIface;
          };
          wireguardConfig = {
            PrivateKeyFile = config.sops.secrets."wg-kenobi-public/private-key".path;
            ListenPort = 63001;
          };
          wireguardPeers = [
            {
              PublicKey = lib.removeSuffix "\n" (
                builtins.readFile ../kenobi/_networks/wg-public/wg-public.pub
              );
              AllowedIPs = [
                "0.0.0.0/0"
              ];
              Endpoint = "romaindeville.xyz:${toString wgPubPort}";
            }
          ];
        };

        "4001-${wgPriIface}" = {
          enable = true;
          netdevConfig = {
            Kind = "wireguard";
            Name = wgPriIface;
          };
          wireguardConfig = {
            PrivateKeyFile = config.sops.secrets."wg-kenobi-private/private-key".path;
            ListenPort = 64001;
          };
          wireguardPeers = [
            {
              PublicKey = lib.removeSuffix "\n" (
                builtins.readFile ../kenobi/_networks/wg-private/wg-private.pub
              );
              AllowedIPs = [
                "${wgPriPrefix}.0/24"
              ];
              Endpoint = "romaindeville.xyz:${toString wgPriPort}";
            }
          ];
        };
      };

      networks = {
        # wlp170s0 = {
        #   matchConfig = {
        #     Name = "wlp170s0";
        #   };
        #   routes = [
        #     {
        #       Destination = "89.234.140.170/32";
        #       Table = "main";
        #     }
        #   ];
        # };

        wg-kenobi-pub = {
          enable = true;
          matchConfig = {
            Name = wgPubIface;
          };
          address = [
            "${wgPubIp}/24"
          ];
          gateway = [
            "${wgPubPrefix}.1"
          ];
          networkConfig = {
            # IPMasquerade = "ipv4";
            IPv6AcceptRA = false;
          };
          # routes = [
          #   {
          #     Destination = "89.234.140.170/32";
          #     Gateway = "192.168.1.1";
          #     Table = "main";
          #   }
          #   {
          #     Destination = "0.0.0.0/0";
          #     Gateway = "172.17.1.1";
          #     Table = "main";
          #   }
          # ];
          linkConfig = {
            RequiredForOnline = "no";
          };
          DHCP = "no";
        };
        wg-kenobi-pri = {
          enable = true;
          matchConfig = {
            Name = wgPriIface;
          };
          address = [
            "${wgPriIp}/24"
          ];
          networkConfig = {
            IPv6AcceptRA = false;
          };
          linkConfig = {
            # Interface down by default and when os switch since its a very
            # sensible interface. Must be activated by a sudo user with command:
            # `sudo ip link set wg-kenobi-pri up`
            ActivationPolicy = "down";
            RequiredForOnline = "no";
          };
          DHCP = "no";
        };
      };
    };
  };

  networking = {
    hosts = {
      "192.168.1.10" = ["kenobi" "kenobi.tekunix.internal"];
    };

    networkmanager = {
      enable = true;
    };
  };
}
