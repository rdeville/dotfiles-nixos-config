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
        image = ../../assets/images/devices/workstation.png;
      };

      interfaces = {
        enp0s25 = {
          addresses = ["172.16.1.30"];
          physicalConnections = [
            (mkLib.mkConnection "switch" "eth1")
          ];
        };
        wg-kenobi-pri = {
          type = "wireguard";
          physicalConnections = [
            (mkLib.mkConnection "kenobi" "wg-private")
          ];
        };
        wg-kenobi-pub = {
          type = "wireguard";
          physicalConnections = [
            (mkLib.mkConnection "kenobi" "wg-public")
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
