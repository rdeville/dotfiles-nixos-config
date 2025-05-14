{config, ...}: let
  mkLib = config.lib.topology;
in {
  # Add a node for the internet
  nodes = {
    internet = mkLib.mkInternet {
      connections = [
        (mkLib.mkConnection "isp-router" "wan"
          // {
            renderer.reverse = true;
          })
        (mkLib.mkConnection "illyse" "wan"
          // {
            renderer.reverse = true;
          })
        (mkLib.mkConnection "darth-vader" "eth0"
          // {
            renderer.reverse = true;
          })
        (mkLib.mkConnection "darth-plagueis" "eth0")
      ];
    };

    illyse = {
      name = "Illyse VPNs";
      deviceType = "router";

      interfaces = {
        "*" = {
          type = "wireguard";
          virtual = true;
        };
        wan = {
          network = "internet";
        };
      };
    };

    isp-router = {
      deviceType = "router";

      interfaces = {
        wan = {
          network = "internet";
        };
        eth1 = {
          addresses = ["192.168.1.1"];
          network = "home-wan";
          # physicalConnections = [
          #   (mkLib.mkConnection "darth-maul" "enp0s25"
          #     // {
          #       renderer.reverse = true;
          #     })
          # ];
        };
        wlan = {
          network = "home-wan";
        };
      };
    };

    darth-vader = {
      deviceType = "device";

      interfaces = {
        eth0 = {
          network = "internet";
          addresses = [
            "152.228.170.17"
          ];
        };
      };

      services = {
        mail = {
          name = "RoundCube & SMTP & Postfix";
        };
      };
    };

    darth-plagueis = {
      deviceType = "device";
      interfaces = {
        eth0 = {
          addresses = [
            "A.B.C.D"
          ];
          network = "internet";
        };
        vpn1 = {
          addresses = [
            "89.234.140.170"
          ];
          physicalConnections = [
            (mkLib.mkConnection "illyse" "*")
          ];
        };
      };

      services = {
        nextcloud = {
          name = "Nextcloud";
        };
      };
    };

    k8s-switch = {
      deviceType = "switch";
      interfaces = {
        "k8s-prd@eth0" = {
          network = "k8s-prd";
          virtual = true;
        };
        "k8s-stg@eth0" = {
          network = "k8s-stg";
          virtual = true;
        };
        eth0 = {
        };
        eth1 = {
          network = "k8s-stg";
        };
        eth2 = {
          network = "k8s-stg";
        };
        eth3 = {};
        eth4 = {};
        eth5 = {};
        eth6 = {};
      };
    };
  };

  networks = {
    internet = {
      name = "Internet";
    };
    home-wan = {
      name = "Home Wan";
      cidrv4 = "192.168.1.0/24";
    };
  };

  # networks.host1-kea.name = "Home LAN";
  # nodes.switch-main = mkLib.mkSwitch "Main Switch" {
  #   info = "D-Link DGS-1016D";
  #   image = ./images/dlink-dgs1016d.png;
  #   interfaceGroups = [["eth1" "eth2" "eth3" "eth4" "eth5" "eth6"]];
  #   connections.eth1 = mkLib.mkConnection "host1" "lan";
  #   connections.eth2 = mkLib.mkConnection "host2" "eth0";
  #   connections.eth3 = mkLib.mkConnection "switch-livingroom" "eth1";
  # };
  #
  # nodes.switch-livingroom = mkLib.mkSwitch "Livingroom Switch" {
  #   info = "D-Link DGS-105";
  #   image = ./images/dlink-dgs105.png;
  #   interfaceGroups = [["eth1" "eth2" "eth3" "eth4" "eth5"]];
  #   connections.eth2 = mkLib.mkConnection "desktop" "eth0";
  #   connections.eth3 = mkLib.mkConnection "laptop" "eth0";
  # };
}
