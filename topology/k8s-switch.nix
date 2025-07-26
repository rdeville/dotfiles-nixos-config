{config, ...}: {
  nodes = {
    k8s-switch = {
      deviceType = "device";
      deviceIcon = "devices.switch";

      hardware = {
        info = "Ethernet Switch for k8s network stg and prd";
        image = ../assets/images/devices/switch.png;
      };

      interfaces = {
        eth0 = {
          addresses = [
            "172.16.3.100"
          ];
          mac = "Ports: 443";
          physicalConnections = [
            (config.lib.topology.mkConnectionRev "kenobi" "eth-k8s")
          ];
        };

        k8s-stg = {
          virtual = true;
          physicalConnections = [
            (config.lib.topology.mkConnectionRev "kenobi" "k8s-stg")
          ];
        };

        k8s-prd = {
          virtual = true;
          physicalConnections = [
            (config.lib.topology.mkConnectionRev "kenobi" "k8s-prd")
          ];
        };

        eth = {
          network = "eth-k8s";
        };
      };
    };
  };
}
