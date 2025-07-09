{config, ...}: let
  mkLib = config.lib.topology;
in {
  nodes = {
    isp-router = {
      deviceType = "router";

      renderer = {
        preferredType = "card";
      };

      hardware = {
        info = "Box Fibre Red SFR";
        image = ../assets/images/devices/box-sfr.png;
      };

      interfaces = {
        wan = {
          icon = "interfaces.fiber-duplex";
          physicalConnections = [
            (mkLib.mkConnectionRev "internet" "*")
          ];
          network = "internet";
        };
        eth1 = {
          addresses = [
            "192.168.1.1"
          ];
          network = "isp-public";
        };
        wlan = {
          network = "isp-public";
        };
      };
      services = {
        kea-dhcp = {
          name = "DHCP Server";
          icon = ../assets/images/services/kea.png;
        };
      };
    };
  };

  networks = {
    isp-public = {
      name = "ISP Public Network";
      cidrv4 = "192.168.1.0/24";
      style = {
        primaryColor = "#f6339a";
        secondaryColor = null;
        pattern = "solid";
      };
    };
  };
}
