{config, ...}: let
  network = "wg-tun-illyse";
  secretPath = "network/${network}/private-key";
  allowedIPs = "0.0.0.0/0";
  prefix = "89.234.140";
in {
  sops = {
    secrets = {
      ${secretPath} = {
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

  os = {
    flavors = {
      network = {
        networks = {
          enp1s0 = {
            routes = [
              {
                Destination = "${prefix}.7/32";
                Gateway = "192.168.1.1";
              }
            ];
          };
          # Default WAN
          wg-tun-illyse = {
            mtu = 1400;
            activationPolicy = "up";
            requiredForOnline = "no";
            address = [
              "${prefix}.170/24"
            ];
            routes = [
              {
                Destination = "${prefix}.7/32";
                Gateway = "192.168.1.1";
              }
              {
                Destination = allowedIPs;
              }
            ];

            allowedTCPPorts =
              config.services.openssh.ports
              ++ [
                53 # DNS
              ];
            allowedUDPPorts = [
              53 # DNS
            ];
            nftables = {
              allowInput = true;
              allowInputConnected = true;
              allowNat = true;
            };
            networkConfig = {
              IPMasquerade = "ipv4";
              IPv4Forwarding = true;
            };
            wireguard = {
              enable = true;
              privateKeyFile = config.sops.secrets."${secretPath}".path;
              peers = [
                {
                  PublicKey = ./illyse.pub;
                  AllowedIPs = allowedIPs;
                  Endpoint = "vpn-wg.illyse.org:443";
                }
              ];
            };
            topology = {
              connections = [
                {
                  to = "illyse";
                  iface = "wg0";
                  reversed = true;
                }
              ];
            };
          };
        };
      };
    };
  };
}
