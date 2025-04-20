{config, ...}: let
  mkLib = config.lib.topology;
in {
  topology = {
    self = {
      interfaces = {
        "k8s-stg@enp0s1" = {
          addresses = ["172.16.144.10"];
          type = "ethernet";
          virtual = true;
          network = "k8s-stg";
          physicalConnections = [
            (mkLib.mkConnection "k8s-switch" "eth2")
          ];
        };
      };

      services = {
        k8s = {
          name = "Kubernetes CP";
        };
      };
    };
  };
}
