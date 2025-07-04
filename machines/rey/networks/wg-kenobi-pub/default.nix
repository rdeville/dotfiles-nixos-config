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
in {
  sops = {
    secrets = {
      "wg-kenobi-public/private-key" = {
        sopsFile = ../../_keys/wg-public.private.key.enc.txt;
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
                builtins.readFile ../../../kenobi/networks/wg-public/wg-public.pub
              );
              AllowedIPs = [
                "0.0.0.0/0"
              ];
              Endpoint = "89.234.140.170:${toString wgPubPort}";
            }
          ];
        };
      };

      networks = {
        wg-kenobi-pub = {
          enable = true;
          matchConfig = {
            Name = wgPubIface;
          };
          address = [
            "${wgPubIp}/24"
          ];
          dns = [
            "${wgPubPrefix}.1"
          ];
          gateway = [
            "${wgPubPrefix}.1"
          ];
          networkConfig = {
            # IPMasquerade = "ipv4";
            IPv6AcceptRA = false;
          };
          linkConfig = {
            RequiredForOnline = "no";
          };
          DHCP = "no";
        };
      };
    };
  };
}
