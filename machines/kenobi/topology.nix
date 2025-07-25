{lib, ...}: {
  topology = {
    extractors = {
      kea = {
        enable = false;
      };
    };

    self = {
      deviceType = lib.mkForce "router";
      deviceIcon = "devices.nixos";

      renderer = {
        preferredType = "card";
      };

      hardware = {
        info = "Intel N100 @ 3.40 GHz, 16Go DDR5.";
        image = ../../assets/images/devices/kenobi.png;
      };

      services = {
        openssh = {
          hidden = false;
          info = lib.mkForce "";
        };

        kea = {
          name = "Kea DHCP";
          info = "DHCP Server";
          icon = ../../assets/images/services/kea.png;
          details = {
            ethernet = {
              text = "Pool: 172.16.1.64 -> 172.16.1.254";
            };
            wifi = {
              text = "Pool: 172.16.2.64 -> 172.16.2.254";
            };
          };
        };
      };
    };
  };
}
