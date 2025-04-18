{config, ...}: let
  mkLib = config.lib.topology;
in {
  topology = {
    self = {
      interfaces = {
        wlp0s1 = {
          addresses = [
            "192.168.1.20"
          ];
          network = "home-wan";
          physicalConnections = [
            (mkLib.mkConnection "isp-router" "wlan")
          ];
        };
        "eth-public@wlp0s1" = {
          addresses = [
            "176.12.2.20"
          ];
          network = "eth-public";
          virtual = true;
          type = "wifi";
          physicalConnections = [
            (mkLib.mkConnection "kenobi" "wlp5s0f0")
          ];
        };
      };
    };
  };
}
