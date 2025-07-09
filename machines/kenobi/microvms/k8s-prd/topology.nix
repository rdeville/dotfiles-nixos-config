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
            "172.20.0.128"
          ];
          physicalConnections = [
            (mkLib.mkConnectionRev "kenobi" "vm-k8s-prd")
          ];
        };
        wg-k8s-prd = {
          network = "wg-k8s-prd";
          addresses = [
            "172.30.128.201"
          ];
          physicalConnections = [
            (mkLib.mkConnectionRev "kenobi" "wg-k8s-prd")
          ];
        };
      };
    };
  };
}
