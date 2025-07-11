{lib, ...}: {
  topology = {
    self = {
      hardware = {
        info = "Intel i7 2600K @ 3.6GHz, 16Go DDR3 ";
        image = ../../assets/images/devices/workstation.png;
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
