{config, ...}: let
  mkLib = config.lib.topology;
in {
  topology = {
    self = {
      interfaces = {
        "k8s-stg@enp0s1" = {
          addresses = ["172.16.144.20"];
          type = "ethernet";
          virtual = true;
          network = "k8s-stg";
          physicalConnections = [
            (mkLib.mkConnection "k8s-switch" "eth1")
          ];
        };
      };

      services = {
        k8s = {
          name = "Kubernetes Worker";
        };
      };
    };
  };
}
