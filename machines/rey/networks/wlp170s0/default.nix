{...}: {
  systemd = {
    network = {
      networks = {
        wlp170s0 = {
          matchConfig = {
            Name = "wlp170s0";
          };
          dns = [
            "89.234.140.170"
          ];
        };
      };
    };
  };
}
