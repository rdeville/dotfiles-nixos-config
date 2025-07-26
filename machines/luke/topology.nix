{lib, ...}: {
  topology = {
    self = {
      hardware = {
        info = "Intel Celeron N3000 @ 1.04GHz, 4Go DDR3";
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
