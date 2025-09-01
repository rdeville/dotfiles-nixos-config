{
  config,
  lib,
  ...
}: {
  topology = {
    self = {
      hardware = {
        info = "Intel i7-1165G7 @ 4.70 GHz, 32Go DDR5";
        image = ../../assets/images/devices/framework.png;
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
