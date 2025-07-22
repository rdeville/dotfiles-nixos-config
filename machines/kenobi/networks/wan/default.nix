{config, ...}: {
  os = {
    flavors = {
      network = {
        networks = {
          # Default WAN
          enp1s0 = {
            DHCP = "yes";
            activationPolicy = "up";
            requiredForOnline = "routable";
            allowedTCPPorts =
              config.services.openssh.ports
              ++ [
                53
              ];
            allowedUDPPorts = [
              53
            ];
            nftables = {
              allowInput = true;
              allowInputConnected = true;
              allowNat = true;
            };
            topology = {
              addresses = [
                "192.168.1.10"
              ];
              connections = [
                {
                  to = "isp-router";
                  iface = "eth1";
                  reversed = true;
                }
              ];
            };
          };
        };
      };
    };
  };
}
