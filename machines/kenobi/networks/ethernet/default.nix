{...}: let
  networks = [
    {
      name = "eth-public";
      interface = "enp2s*";
      realInterface = "enp2s0";
      id = 1;
      reservations = [];
      topology = {
        color = "#00a63e";
        desc = "Local Ethernet";
      };
    }
  ];
in {
  os = {
    flavors = {
      network = {
        networks = builtins.foldl' (acc: elem:
          {
            ${elem.name} = let
              prefix = "172.16.${toString elem.id}";
            in {
              interface = elem.interface;
              isServer = true;
              activationPolicy = "up";
              nftables = {
                allowInputConnected = true;
                allowBidirectional = true;
              };
              requiredForOnline = "no";
              networkCIDRPrefix = prefix;
              address = [
                "${prefix}.1/24"
              ];
              allowedTCPPorts = [
                53 # DNS
              ];
              allowedUDPPorts = [
                53 # DNS
                67 # DHCP
              ];
              nftables = {
                tunInterfaces = [
                  "wg-tun-illyse"
                ];
              };
              topology = {
                addresses = [
                  "${prefix}.1"
                ];
                inherit (elem.topology) color desc;
              };
            };
          }
          // acc) {}
        networks;
      };
    };
  };

  services = {
    kea = {
      dhcp4 = {
        enable = true;
        settings = {
          subnet4 =
            builtins.map (
              elem: let
                prefix = "172.16.${toString elem.id}";
              in {
                inherit (elem) id;
                subnet = "${prefix}.0/24";
                interface = elem.realInterface;
                reservations = builtins.foldl' (acc: elem:
                  [
                    {
                      inherit (elem) hw-address hostname;
                      ip-address = "${prefix}.${toString elem.id}";
                    }
                  ]
                  ++ acc) []
                elem.reservations;
                option-data = [
                  {
                    name = "routers";
                    data = "172.16.${toString elem.id}.1";
                  }
                  {
                    name = "domain-name-servers";
                    data = "172.16.${toString elem.id}.1";
                  }
                ];
              }
            )
            networks;
        };
      };
    };
  };
}
