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
        info = "Intel i7-1165G7 @ 4.70 GHz, 32Go DDR5";
        image = ../../assets/images/devices/framework.png;
      };

      interfaces = {
        wlp170s0 = {
          addresses = [
            "172.16.1.3"
          ];
          physicalConnections = [
            (mkLib.mkConnectionRev "kenobi" "wlp5s0f0")
          ];
        };
        wg-private = {
          physicalConnections = [
            (mkLib.mkConnectionRev "kenobi" "wg-private")
          ];
        };
        wg-public = {
          physicalConnections = [
            (mkLib.mkConnectionRev "kenobi" "wg-public")
          ];
        };
        wg-k8s-dev = {
          physicalConnections = [
            (mkLib.mkConnectionRev "kenobi" "wg-k8s-dev")
          ];
        };
        enp0s1 = {
          addresses = [
            "172.16.0.3"
          ];
          physicalConnections = [
            (mkLib.mkConnectionRev "switch" "eth2")
          ];
        };
      };
      services = {
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
