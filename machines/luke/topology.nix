{
  config,
  lib,
  ...
}: {
  topology = {
    self = {
      hardware = {
        info = "TODO";
        image = ../../assets/images/devices/brix.png;
      };

      interfaces = {
        enp0s1 = {
          addresses = [
            "172.16.144.20"
          ];
          type = "ethernet";
          network = "k8s-stg";
          physicalConnections = [
            (config.lib.topology.mkConnectionRev "k8s-switch" "eth1")
          ];
        };

        wg-kenobi-pri = {
          addresses = [
            "172.18.1.146"
          ];
          type = "wireguard";
          virtual = true;
          physicalConnections = [
            (config.lib.topology.mkConnectionRev "kenobi" "wg-private")
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
