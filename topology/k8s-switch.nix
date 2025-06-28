{config, ...}: let
  mkLib = config.lib.topology;
in {
  nodes = {
    k8s-switch = {
      deviceType = "device";
      deviceIcon = "devices.switch";

      hardware = {
        info = "Ethernet Switch for k8s network stg and prd";
        image = ../assets/images/devices/switch.png;
      };

      interfaces = {
        "k8s-stg@eth0" = {
          virtual = true;
          physicalConnections = [
            (mkLib.mkConnection "kenobi" "k8s-stg")
          ];
        };

        "k8s-prd@eth0" = {
          virtual = true;
          physicalConnections = [
            (mkLib.mkConnection "kenobi" "k8s-prd")
          ];
        };

        eth1 = {
          virtual = true;
          network = "k8s-stg";
        };

        eth2 = {
          network = "k8s-stg";
          virtual = true;
        };

        eth3 = {
          network = "k8s-prd";
          virtual = true;
        };

        eth4 = {
          network = "k8s-prd";
          virtual = true;
        };

        eth5 = {
          network = "k8s-prd";
          virtual = true;
        };
      };
    };
  };
}
