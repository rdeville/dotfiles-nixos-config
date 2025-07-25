{lib, ...}: let
  networks = [
    {
      name = "eth-k8s";
      interface = "enp3s*";
      realInterface = "enp3s0";
      id = 3;
      reservations = [
        {
          hw-address = "8c:90:2d:9d:20:16";
          hostname = "k8s-switch";
          id = 100;
        }
      ];
      topology = {
        color = "#733e0a";
        desc = "Kubernetes Ethernet";
      };
    }
    {
      name = "k8s-prd";
      interface = "eth-k8s";
      vlan = true;
      id = 128;
      reservations = [];
      topology = {
        color = "#ffdf20";
        desc = "VLan Kubernetes Production";
      };
    }
    {
      name = "k8s-stg";
      interface = "eth-k8s";
      vlan = true;
      id = 144;
      reservations = [
        {
          hw-address = "e0:d5:5e:99:3a:d5";
          hostname = "luke";
          id = 11;
        }
        {
          hw-address = "fc:aa:14:dc:88:9f";
          hostname = "leia";
          id = 12;
        }
      ];
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
            in
              {
                vlan = lib.mkIf (elem ? vlan && elem.vlan) {
                  inherit (elem) id;
                  enable = true;
                  vlanInterfaces = [
                    elem.interface
                  ];
                };
                nftables = {
                  allowInput = true;
                  allowInputConnected = true;
                  tunInterfaces = [
                    "wg-tun-illyse"
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
                topology = {
                  inherit (elem.topology) color desc;
                };
              }
              // (
                if (! elem ? vlan || ! elem.vlan)
                then {
                  inherit (elem) interface;
                  topology = {
                    addresses = [
                      "${prefix}.1"
                    ];
                    inherit (elem.topology) color desc;
                  };
                }
                else {}
              );
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
                interface =
                  if (elem ? vlan && elem.vlan)
                  then elem.name
                  else elem.realInterface;
                subnet = "${prefix}.0/24";
                reservations = builtins.foldl' (acc: resa:
                  [
                    {
                      inherit (resa) hw-address hostname;
                      ip-address = "${prefix}.${toString resa.id}";
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
                    data = "${prefix}.1";
                  }
                  {
                    name = "domain-name-servers";
                    data = "${prefix}.1";
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
