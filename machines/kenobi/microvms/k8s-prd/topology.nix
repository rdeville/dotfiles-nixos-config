{lib, ...}: {
  topology = {
    self = {
      services = {
        openssh = {
          hidden = false;
          info = lib.mkForce "";
        };
      };
    };
  };
}
