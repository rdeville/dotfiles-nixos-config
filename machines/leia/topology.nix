{
  config,
  lib,
  ...
}: {
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
            (config.lib.topology.mkConnectionRev "k8s-switch" "eth2")
          ];
        };
        wg-kenobi-pri = {
          addresses = [
            "172.18.1.147"
          ];
          type = "wireguard";
          virtual = true;
          physicalConnections = [
            (config.lib.topology.mkConnectionRev "kenobi" "wg-private")
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
