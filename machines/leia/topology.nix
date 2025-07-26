{lib, ...}: {
  topology = {
    self = {
      hardware = {
        info = "Intel Celeron J1900 @ 1.99GHz, 8Go DDR3";
        image = ../../assets/images/devices/brix.png;
      };

      services = {
        openssh = {
          hidden = false;
          info = lib.mkForce "";
        };
      };
    };
  };
}
