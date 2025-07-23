{
  self,
  config,
  lib,
  ...
}: let
  id = 203;

  k8sPorts = import ../../../../common/config/k8s.nix {inherit config;};
  routerNetwork = self.nixosConfigurations.kenobi.config.os.flavors.network.networks;
  wgEndpoint = "89.234.140.170";

  wgNetworks = [
    (let
      name = "wg-private";
    in {
      inherit name;
      activationPolicy = "up";
      endpoint = wgEndpoint;
      allowInput = true;
      allowedTCPPorts = config.services.openssh.ports;
      allowedIPs = routerNetwork.${name}.networkCIDR;
      address = [
        "172.18.160.${toString id}/${routerNetwork.${name}.networkCIDRLength}"
      ];
      routes = [
        {
          Destination = routerNetwork.${name}.networkCIDR;
        }
      ];
    })
    (let
      name = "wg-k8s-dev";
    in {
      inherit name;
      inherit
        (k8sPorts)
        allowedUDPPorts
        allowedTCPPorts
        ;
      activationPolicy = "up";
      allowInput = true;
      allowBidirectional = true;
      allowInputConnected = true;
      endpoint = wgEndpoint;
      allowedIPs = routerNetwork.${name}.networkCIDR;
      tunInterfaces = [
        "cilium_wg0"
      ];
      routes = [
        {
          Destination = routerNetwork.${name}.networkCIDR;
        }
      ];
    })
  ];

  vm = {
    interface = "enp0s8";
    network = "vm-k8s-dev";
    prefix = "172.20.160";
    mac = "02:00:00:00:00:a0";
  };
in {
  sops = {
    secrets = builtins.foldl' (acc: elem:
      {
        "network/${elem.name}/private-key" = {
          sopsFile = ./_keys/${elem.name}.private.key.enc.txt;
          format = "binary";
          group = config.users.users.systemd-network.group;
          mode = "0640";
          reloadUnits = [
            "systemd-networkd.service"
          ];
        };
      }
      // acc) {}
    wgNetworks;
  };

  microvm = {
    interfaces = [
      {
        type = "tap";
        id = vm.network;
        mac = vm.mac;
      }
    ];
  };

  os = {
    flavors = {
      network = {
        enable = true;
        firewall = {
          trustedInterfaces = k8sPorts.trustedInterfaces;
        };
        networks =
          {
            ${vm.interface} = {
              interface = vm.interface;
              matchConfig =  {
                name = "enx*";
              };
              allowedTCPPorts = config.services.openssh.ports;
              activationPolicy = "up";
              nftables = {
                allowInput = true;
                allowInputConnected = true;
                allowBidirectional = true;
              };
              address = [
                "${vm.prefix}.${toString id}/32"
              ];
              routes = [
                {
                  # A route to the host
                  Destination = "${vm.prefix}.0/32";
                  GatewayOnLink = true;
                }
                {
                  # Default route
                  Destination = "0.0.0.0/0";
                  Gateway = "${vm.prefix}.1";
                  GatewayOnLink = true;
                }
              ];
              topology = {
                name = vm.network;
                addresses = [
                  "${vm.prefix}.${toString id}"
                ];
              };
            };
          }
          // lib.mkWgNetworkClient "kenobi" wgNetworks id config;
      };
    };
  };
}
