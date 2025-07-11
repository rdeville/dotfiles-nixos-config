{
  config,
  lib,
  ...
}: {
  topology = {
    self = {
      hardware = {
        info = "Intel i7-1165G7 @ 4.70 GHz, 32Go DDR5";
        image = ../../assets/images/devices/framework.png;
      };

      interfaces = {
        eth-public = {
          addresses = [
            "172.16.1.3"
          ];
          mac = "No Open Ports";
          physicalConnections = [
            (config.lib.topology.mkConnectionRev "switch" "eth2")
          ];
        };
      };

      services = {
        openssh = {
          hidden = false;
          info = lib.mkForce "";
        };
      };
    };
  };
}
