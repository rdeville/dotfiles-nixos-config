{
  config,
  lib,
  ...
}: let
  mkLib = config.lib.topology;
in {
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
            (mkLib.mkConnectionRev "k8s-switch" "eth1")
          ];
        };

        wg-kenobi-pri = {
          addresses = [
            "172.18.1.146"
          ];
          type = "wireguard";
          virtual = true;
          physicalConnections = [
            (mkLib.mkConnectionRev "kenobi" "wg-private")
          ];
        };
      };

      services = {
        k8s = {
          name = "Kubernetes Worker";
          icon = ../../assets/images/services/kubernetes.png;
        };

        openssh = {
          hidden = false;
          name = "OpenSSH";
          icon = "services.openssh";
          info = lib.mkForce "";
        };
      };
    };
  };
}
