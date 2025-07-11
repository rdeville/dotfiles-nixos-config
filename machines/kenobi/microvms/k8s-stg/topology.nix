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
            "172.20.144.201"
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
