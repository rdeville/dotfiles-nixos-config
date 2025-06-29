{config, ...}: let
  mkLib = config.lib.topology;
in {
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
            (mkLib.mkConnection "kenobi" "enp2s0")
          ];
        };
        eth1 = {};
        eth2 = {};
      };
    };
  };
}
