{config, ...}: {
  nodes = {
    switch = {
      deviceType = "switch";

      hardware = {
        info = "Ethernet Switch for eth-public";
        image = ../assets/images/devices/switch.png;
      };

      interfaces = {
        eth0 = {
          physicalConnections = [
            (config.lib.topology.mkConnectionRev "kenobi" "eth-public")
          ];
        };
        eth1 = {};
        eth2 = {};
      };
    };
  };
}
