{...}: let
  network = "wlp170s0";
in {
  systemd = {
    network = {
      networks = {
        ${network} = {
          matchConfig = {
            Name = network;
          };
          dns = [
            "89.234.140.170"
          ];
        };
      };
    };
  };

  networking = {
    firewall = {
      interfaces = {
        ${network} = {
          allowedTCPPorts = [];
          allowedUDPPorts = [];
        };
      };
    };
  };
}
