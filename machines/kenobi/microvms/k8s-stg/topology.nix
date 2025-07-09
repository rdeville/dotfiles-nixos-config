{
  config,
  lib,
  ...
}: let
  mkLib = config.lib.topology;
in {
  topology = {
    self = {
      services = {
        k8s = {
          name = "Kubernetes CP & Worker";
          icon = ../../../../assets/images/services/kubernetes.png;
        };

        openssh = {
          hidden = false;
          name = "OpenSSH";
          icon = "services.openssh";
          info = lib.mkForce "";
        };
      };
      interfaces = lib.mkForce {
        eth = {
          addresses = [
            "172.20.0.144"
          ];
          physicalConnections = [
            (mkLib.mkConnectionRev "kenobi" "vm-k8s-stg")
          ];
        };
        wg-k8s-stg = {
          network = "wg-k8s-stg";
          addresses = [
            "172.30.144.201"
          ];
          physicalConnections = [
            (mkLib.mkConnectionRev "kenobi" "wg-k8s-stg")
          ];
        };
      };
    };
  };
}
