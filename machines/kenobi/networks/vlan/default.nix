{...}: let
  networks = [
    {
      name = "k8s-prd";
      id = 128;
      reservations = [];
      topology = {
        color = "#ffdf20";
        desc = "VLan Kubernetes Production";
      };
    }
    {
      name = "k8s-stg";
      id = 144;
      reservations = [];
      topology = {
        color = "#f0b100";
        desc = "VLan Kubernetes Staging";
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
              vlan = {
                inherit (elem) id;
                enable = true;
                vlanInterfaces = [
                  "enp3s0"
                ];
              };
              isServer = true;
              activationPolicy = "up";
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
          interfaces-config = {
            interfaces = builtins.map (elem: elem.name) networks;
          };
          subnet4 =
            builtins.map (
              elem: let
                prefix = "172.16.${toString elem.id}";
              in {
                inherit (elem) id;
                subnet = "${prefix}.0/24";
                interface = elem.name;
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
