{
  config,
  lib,
  ...
}: {
  topology = {
    self = {
      hardware = {
        info = "TODO";
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
