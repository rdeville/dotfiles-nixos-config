{
  self,
  config,
  lib,
  ...
}: let
  id = 12;

  k8sPorts = import ../../common/config/k8s.nix {inherit config;};
  routerNetwork = self.nixosConfigurations.kenobi.config.os.flavors.network.networks;
  prefix = "172.16.144";
  wgEndpoint = "${prefix}.1";

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
        "172.18.144.${toString id}"
      ];
      routes = [
        {
          Destination = routerNetwork.${name}.networkCIDR;
        }
      ];
    })
    (
      let
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
          trustedInterfaces = k8sPorts.trustedInterfaces;
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

            k8s-stg = {
              interface = "k8s-stg";
              DHCP = "yes";
              activationPolicy = "up";
              requiredForOnline = "yes";
              nftables = {
                allowInputConnected = true;
              };
              vlan = {
                enable = true;
                id = 144;
                vlanInterfaces = [
                  "eth-k8s"
                ];
              };
              topology = {
                addresses = [
                  "${prefix}.${toString id}"
                ];
                connections = [
                  {
                    to = "kenobi";
                    iface = "k8s-stg";
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
