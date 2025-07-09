{
  config,
  lib,
  ...
}: let
  mkLib = config.lib.topology;
in {
  topology = {
    extractors = {
      kea = {
        enable = false;
      };
    };

    self = {
      deviceType = lib.mkForce "router";
      deviceIcon = "devices.nixos";

      renderer = {
        preferredType = "card";
      };

      hardware = {
        info = "Intel N100 @ 3.40 GHz, 16Go DDR5.";
        image = ../../assets/images/devices/kenobi.png;
      };

      interfaces = {
        enp1s0 = {
          addresses = [
            "192.168.1.10"
          ];
          type = "ethernet";
          physicalConnections = [
            (mkLib.mkConnectionRev "isp-router" "eth1")
          ];
        };

        wg-illyse = {
          type = "wireguard";
          addresses = [
            "89.234.140.170"
          ];
          physicalConnections = [
            (mkLib.mkConnectionRev "illyse" "wg0")
          ];
        };
      };

      services = {
        openssh = {
          hidden = false;
          info = lib.mkForce "";
        };

        kea = {
          name = "Kea DHCP";
          info = "DHCP Server";
          icon = ../../assets/images/services/kea.png;
          details = {
            ethernet = {
              text = "Pool: 172.168.0.64 -> 172.168.0.254";
            };
            wifi = {
              text = "Pool: 172.168.1.64 -> 172.168.1.254";
            };
          };
        };
      };
    };
  };
}
