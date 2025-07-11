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
            "172.20.160.203"
          ];
          physicalConnections = [
            (mkLib.mkConnectionRev "rey" "vm-k8s-dev")
          ];
        };
        wg-k8s-dev = {
          network = "wg-k8s-dev";
          addresses = [
            "172.30.160.203"
          ];
          physicalConnections = [
            (mkLib.mkConnectionRev "kenobi" "wg-k8s-dev")
          ];
        };
      };
    };
  };
}
