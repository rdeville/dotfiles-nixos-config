{
  self,
  config,
  lib,
  ...
}: let
  id = 2;

  routerNetwork = self.nixosConfigurations.kenobi.config.os.flavors.network.networks;
  wgEndpoint = "172.16.1.1";

  wgClusters = (
    let
      clusters = [
        {
          name = "wg-k8s-prd";
          id = 128;
          color = "#8ec5ff";
        }
        {
          name = "wg-k8s-stg";
          id = 144;
          color = "#2b7fff";
        }
        {
          name = "wg-k8s-dev";
          id = 160;
          color = "#1447e6";
        }
      ];
    in
      builtins.foldl' (acc: elem:
        [
          {
            inherit (elem) name;
            interface = elem.name;
            endpoint = wgEndpoint;
            allowedIPs = routerNetwork.${elem.name}.networkCIDR;
            allowInputConnected = true;
            routes = [
              {
                Destination = routerNetwork.${elem.name}.networkCIDR;
              }
            ];
          }
        ]
        ++ acc) []
      clusters
  );

  wgNetworks =
    [
      (let
        name = "wg-private";
      in {
        inherit name;
        interface = name;
        endpoint = wgEndpoint;
        activationPolicy = "up";
        allowInput = true;
        allowedTCPPorts = config.services.openssh.ports;
        allowedIPs = routerNetwork.${name}.networkCIDR;
        routes = [
          {
            Destination = routerNetwork.${name}.networkCIDR;
          }
        ];
      })
    ]
    ++ wgClusters;
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
      network = {
        enable = true;
        nameservers = [
          # Kenobi
          "89.234.140.170"
        ];
        networks =
          {
            eth-public = {
              interface = "eno1";
              matchConfig = {
                name = "eno*";
              };
              DHCP = "yes";
              dns = [
                "172.16.1.1"
              ];
              activationPolicy = "up";
              requiredForOnline = "yes";
              nftables = {
                allowInputConnected = true;
              };
              topology = {
                addresses = [
                  "172.16.1.2"
                ];
                connections = [
                  {
                    to = "switch";
                    iface = "eth";
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
