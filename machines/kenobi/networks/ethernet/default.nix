{...}: let
  networks = [
    {
      name = "eth-public";
      interface = "enp2s*";
      realInterface = "enp2s0";
      id = 1;
      reservations = [
        {
          hw-address = "10:bf:48:7c:c8:e6";
          hostname = "darth-maul";
          id = 2;
        }
      ];
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
              interface = elem.realInterface;
              matchConfig = {
                name = elem.interface;
              };
              isServer = true;
              activationPolicy = "up";
              nftables = {
                # Required for DNS
                allowInput = true;
                forward = {
                  bidirectional = true;
                  outputInterfaces = [
                    "wg-tun-illyse"
                  ];
                };
              };
              requiredForOnline = "no";
              networkCIDRPrefix = prefix;
              address = [
                "${prefix}.1/24"
              ];
              allowedTCPPorts = [
                53 # DNS
                80 # HTTP
                443 # HTTPs
              ];
              allowedUDPPorts = [
                53 # DNS
                67 # DHCP
              ];
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
                pools = [
                  {
                    pool = "${prefix}.64 - ${prefix}.254";
                  }
                ];
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
