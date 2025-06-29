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
            "172.16.2.20"
          ];
          physicalConnections = [
            (mkLib.mkConnection "kenobi" "wlp5s0f0")
          ];
        };
        wg-kenobi-pri = {
          physicalConnections = [
            (mkLib.mkConnection "kenobi" "wg-private")
          ];
        };
        wg-kenobi-pub = {
          physicalConnections = [
            (mkLib.mkConnection "kenobi" "wg-public")
          ];
        };
        enp0s1 = {
          addresses = [
            "172.16.1.20"
          ];
          physicalConnections = [
            (mkLib.mkConnection "switch" "eth2")
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
