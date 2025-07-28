{...}: {
  os = {
    flavors = {
      network = {
        networks = {
          # Default WAN
          wan = {
            interface = "enp1s0";
            matchConfig = {
              name = "enp1s*";
            };
            DHCP = "yes";
            activationPolicy = "up";
            requiredForOnline = "routable";
            nftables = {
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
