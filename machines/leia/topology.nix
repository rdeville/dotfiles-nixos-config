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
        "enp0s1" = {
          addresses = [
            "172.16.144.10"
          ];
          type = "ethernet";
          virtual = true;
          physicalConnections = [
            (mkLib.mkConnectionRev "k8s-switch" "eth2")
          ];
        };
        wg-kenobi-pri = {
          addresses = [
            "172.18.1.147"
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
          name = "Kubernetes CP";
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
