{
  config,
  lib,
  ...
}: let
  wgPriIface = "wg-kenobi-pri";
  wgPriPort = 65143;
  wgPriPrefix = "172.18.0";
  wgPriIp = "${wgPriPrefix}.${toString wgPriId}";
  wgPriId = 20;
in {
  sops = {
    secrets = {
      "wg-kenobi-private/private-key" = {
        sopsFile = ../../_keys/wg-private.private.key.enc.txt;
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
                builtins.readFile ../../../kenobi/networks/wg-private/wg-private.pub
              );
              AllowedIPs = [
                "${wgPriPrefix}.0/16"
              ];
              Endpoint = "89.234.140.170:${toString wgPriPort}";
            }
          ];
        };
      };

      networks = {
        wg-kenobi-pri = {
          enable = true;
          matchConfig = {
            Name = wgPriIface;
          };
          address = [
            "${wgPriIp}/16"
          ];
          dns = [
            "${wgPriPrefix}.1"
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
}
