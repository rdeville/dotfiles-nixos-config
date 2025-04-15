{
  config,
  lib,
  ...
}: {
  topology = {
    self = {
      interfaces = {
        enp0s25 = {
          addresses = ["192.168.1.30"];
        };
      };
    };
  };
}
