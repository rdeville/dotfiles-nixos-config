{
  self,
  config,
  lib,
  ...
}: let
  id = 201;

  k8sPorts = import ../../../../../common/config/k8s.nix {inherit config;};
  routerNetwork = self.nixosConfigurations.kenobi.config.os.flavors.network.networks;
  wgEndpoint = "${vm.prefix}.1";

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
        "172.18.128.${toString id}/${routerNetwork.${name}.networkCIDRLength}"
      ];
      routes = [
        {
          Destination = routerNetwork.${name}.networkCIDR;
        }
      ];
    })
    (let
      name = "wg-k8s-prd";
    in {
      inherit name;
      inherit
        (k8sPorts)
        allowedUDPPorts
        allowedTCPPorts
        ;
      activationPolicy = "up";
      allowBidirectional = true;
      allowInputConnected = true;
      endpoint = wgEndpoint;
      allowedIPs = routerNetwork.${name}.networkCIDR;
      routes = [
        {
          Destination = routerNetwork.${name}.networkCIDR;
        }
      ];
    })
  ];

  vm = {
    network = "vm-k8s-prd";
    prefix = "172.20.128";
    mac = "02:00:00:00:00:a0";
  };
in {
  sops = {
    secrets = builtins.foldl' (acc: elem:
      {
        "network/${elem.name}/private-key" = {
          sopsFile = ../_keys/${elem.name}.private.key.enc.txt;
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
        nftable = {
          enable = false;
        };
        firewall = {
          enable = false;
          inherit (k8sPorts) trustedInterfaces;
        };
        networks =
          {
            ${vm.network} = {
              allowedTCPPorts = config.services.openssh.ports;
              mac = vm.mac;
              activationPolicy = "up";
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
              nftables = {
                allowInput = true;
                allowInputConnected = true;
              };
            };
          }
          // lib.mkWgNetworkClient "kenobi" wgNetworks id config;
      };
    };
  };
}
