{lib, ...}: {
  topology = {
    self = {
      hardware = {
        info = "TODO";
        image = ../../assets/images/devices/acemagic-cyberpunk.png;
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
