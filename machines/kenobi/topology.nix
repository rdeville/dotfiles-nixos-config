{config, ...}: let
  mkLib = config.lib.topology;
in {
  topology = {
    self = {
      interfaces = {
        enp0s1 = {
          addresses = ["192.168.1.10"];
          type = "ethernet";
          physicalConnections = [
            (mkLib.mkConnection "isp-router" "eth1")
          ];
        };

        enp0s2 = {
          addresses = ["172.16.1.1"];
          type = "ethernet";
        };

        "k8s-prd@enp0s3" = {
          network = "k8s-prd";
          addresses = ["172.16.128.1"];
          type = "ethernet";
          virtual = true;
          physicalConnections = [
            (mkLib.mkConnection "k8s-switch" "k8s-prd@eth0"
              // {
                renderer.reverse = true;
              })
          ];
        };

        "k8s-stg@enp0s3" = {
          network = "k8s-stg";
          addresses = ["172.16.144.1"];
          type = "ethernet";
          virtual = true;
          physicalConnections = [
            (mkLib.mkConnection "k8s-switch" "k8s-stg@eth0"
              // {
                renderer.reverse = true;
              })
          ];
        };

        "wg-public@enp0s1" = {
          addresses = ["172.16.3.1"];
          type = "wireguard";
          virtual = true;
        };

        "wg-private@enp0s1" = {
          addresses = ["172.16.4.1"];
          type = "wireguard";
          virtual = true;
        };

        "wg-illyse@enp0s1" = {
          addresses = ["A.B.C.D"];
          type = "wireguard";
          virtual = true;
          physicalConnections = [
            (mkLib.mkConnection "illyse" "*")
          ];
        };

        wlp5s0f0 = {
          addresses = ["172.16.2.1"];
          type = "wifi";
        };
      };

      services = {
        kea = {
          name = "kea-dhcp";
          info = "DHCP Server";
          details = {
            k8s-prd = {
              text = ''
                Pool: 172.168.128.64 -> 172.168.128.254
              '';
            };
            k8s-stg = {
              text = ''
                Pool: 172.168.144.64 -> 172.168.144.254
              '';
            };
          };
        };
      };
    };

    networks = {
      eth-public = {
        name = "Public Ethernet Network";
        cidrv4 = "172.16.1.1/24";
      };

      wlan-public = {
        name = "Public Wireless Network";
        cidrv4 = "172.16.2.1/24";
      };

      k8s-prd = {
        name = "Kubernetes Production Network";
        cidrv4 = "172.16.128.1/24";
      };

      k8s-stg = {
        name = "Kubernetes Staging Network";
        cidrv4 = "172.16.144.1/24";
      };
    };
  };
}
