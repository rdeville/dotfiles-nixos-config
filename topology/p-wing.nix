{config, ...}: {
  nodes = {
    p-wing = {
      deviceType = "device";
      deviceIcon = "devices.laptop";

      hardware = {
        info = "Portable Phone (Pixel 7)";
        image = ../assets/images/devices/pixel-7.png;
      };

      interfaces = {
        wg-public = {
          icon = "interfaces.wireguard";
          addresses = [
            "172.17.0.4"
          ];
          physicalConnections = [
            (config.lib.topology.mkConnectionRev "kenobi" "wg-public")
          ];
        };

        wl-public = {
          icon = "interfaces.wifi";
          addresses = [
            "172.16.2.4"
          ];
          physicalConnections = [
            (config.lib.topology.mkConnectionRev "kenobi" "wl-public")
          ];
        };
      };
    };
  };
}
