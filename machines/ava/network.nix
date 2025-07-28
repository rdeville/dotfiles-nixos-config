{
  self,
  config,
  lib,
  ...
}: let
  id = 23;

  k8sPorts = import ../../common/config/k8s.nix {inherit config;};
  routerNetwork = self.nixosConfigurations.kenobi.config.os.flavors.network.networks;
  prefix = "172.16.128";
  wgEndpoint = "${prefix}.1";

  wgNetworks = [
    (let
      name = "wg-private";
    in {
      inherit name;
      interface = name;
      endpoint = wgEndpoint;
      activationPolicy = "up";
      allowInput = true;
      allowInputConnected = true;
      allowedTCPPorts = config.services.openssh.ports;
      allowedIPs = routerNetwork.${name}.networkCIDR;
      address = [
        "172.18.128.${toString id}"
      ];
      routes = [
        {
          Destination = routerNetwork.${name}.networkCIDR;
        }
      ];
    })
    (
      let
        name = "wg-k8s-prd";
      in {
        inherit name;
        inherit
          (k8sPorts)
          allowedUDPPorts
          allowedTCPPorts
          ;
        interface = name;
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
      }
    )
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

  os = {
    flavors = {
      ssh-server = {
        openFirewall = true;
      };
      network = {
        enable = true;
        firewall = {
          enable = false;
          trustedInterfaces = k8sPorts.trustedInterfaces;
        };
        nftable = {
          enable = true;
          defaultPolicy = "accept";
        };
        networks =
          {
            eth-k8s = {
              interface = "enp3s0";
              matchConfig = {
                name = "enp3s*";
              };
              DHCP = "no";
              activationPolicy = "up";
              requiredForOnline = "no";
              nftables = {
                allowInputConnected = true;
              };
              topology = {
                connections = [
                  {
                    to = "k8s-switch";
                    iface = "eth";
                    reversed = true;
                  }
                ];
              };
            };
            k8s-prd = {
              interface = "k8s-prd";
              DHCP = "yes";
              activationPolicy = "up";
              requiredForOnline = "yes";
              nftables = {
                allowInputConnected = true;
              };
              vlan = {
                enable = true;
                id = 128;
                vlanInterfaces = [
                  "enp3s0"
                ];
              };
              topology = {
                addresses = [
                  "${prefix}.${toString id}"
                ];
                connections = [
                  {
                    to = "kenobi";
                    iface = "k8s-prd";
                    reversed = true;
                  }
                ];
              };
            };
          }
          // lib.mkWgNetworkClient "kenobi" wgNetworks id config;
      };
    };
  };
}
