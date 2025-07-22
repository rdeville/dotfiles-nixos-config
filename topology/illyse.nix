{config, ...}: {
  nodes = {
    illyse = {
      name = "illyse";
      deviceType = "router";

      renderer = {
        preferredType = "card";
      };

      hardware = {
        info = "Server Managed by ISP Illyse";
        image = ../assets/images/devices/server-rack-1U.png;
      };

      interfaces = {
        wg0 = {
          type = "wireguard";
          network = "illyse";
          virtual = true;
          addresses = [
            "89.234.140.3"
          ];
        };
        wan = {
          icon = "interfaces.fiber-duplex";
          physicalConnections = [
            (config.lib.topology.mkConnectionRev "internet" "*")
          ];
          network = "internet";
        };
      };

      services = {
        wireguard = {
          name = "WireGuard VPN";
          info = "vpn.illyse.net";
        };
      };
    };
  };

  networks = {
    illyse = {
      name = "Illyse";
      cidrv4 = "89.234.140.0/24";
      style = {
        primaryColor = "#f4a8ff";
        secondaryColor = null;
        pattern = "dotted";
      };
    };
  };
}
