{
  self,
  config,
  lib,
  ...
}: let
  id = 201;
  vm = {
    interface = "enp0s8";
    network = "vm-k8s-stg";
    prefix = "172.20.144";
    mac = "02:00:00:00:00:a0";
  };

  k8sPorts = import ../../../../common/config/k8s.nix {inherit config;};
  routerNetwork = self.nixosConfigurations.kenobi.config.os.flavors.network.networks;
  wgEndpoint = "${vm.prefix}.1";

  wgNetworks = [
    (let
      name = "wg-private";
    in {
      inherit name;
      interface = name;
      activationPolicy = "up";
      endpoint = wgEndpoint;
      allowInput = true;
      allowedTCPPorts = config.services.openssh.ports;
      allowedIPs = routerNetwork.${name}.networkCIDR;
      address = [
        "172.18.144.${toString id}/${routerNetwork.${name}.networkCIDRLength}"
      ];
      routes = [
        {
          Destination = routerNetwork.${name}.networkCIDR;
        }
      ];
    })
    (let
      name = "wg-k8s-stg";
    in {
      inherit name;
      inherit
        (k8sPorts)
        allowedUDPPorts
        allowedTCPPorts
        ;
      interface = name;
      activationPolicy = "up";
      allowInput = true;
      allowInputConnected = true;
      endpoint = wgEndpoint;
      allowedIPs = routerNetwork.${name}.networkCIDR;
      tunInterfaces = [
        # Bidirectional + Trusted Interface
        name
        vm.interface
        "cilium_wg0"
      ];
      routes = [
        {
          Destination = routerNetwork.${name}.networkCIDR;
        }
      ];
    })
  ];
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
          inherit (k8sPorts) trustedInterfaces;
          checkReversePath = false;
        };
        networks =
          {
            ${vm.network} = {
              interface = vm.interface;
              matchConfig = {
                name = "enx*";
              };
              activationPolicy = "up";
              nftables = {
                allowInputConnected = true;
              };
              address = [
                "${vm.prefix}.${toString id}/32"
              ];
              dns = [
                "${vm.prefix}.1"
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
