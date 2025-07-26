{
  self,
  config,
  lib,
  ...
}: let
  id = 3;

  routerNetwork = self.nixosConfigurations.kenobi.config.os.flavors.network.networks;
  wgEndpoint = "89.234.140.170";

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
      {
        name = "wg-public";
        endpoint = wgEndpoint;
        allowedIPs = "0.0.0.0/0";
        routes = [
          {
            Destination = "0.0.0.0/0";
          }
        ];
        allowNat = true;
        allowInputConnected = true;
        tunInterfaces = [
          "wlp170s0"
        ];
        networkConfig = {
          IPMasquerade = "ipv4";
          IPv4Forwarding = true;
        };
      }
      (let
        name = "wg-private";
      in {
        inherit name;
        endpoint = wgEndpoint;
        allowInput = true;
        allowInputConnected = true;
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
        networkmanager = {
          enable = true;
        };
        networks =
          {
            wl-public = {
              interface = "wlp170s0";
              matchConfig = {
                name = "wlp170s*";
              };
              DHCP = "yes";
              activationPolicy = "up";
              requiredForOnline = "yes";
              nftables = {
                allowInput = true;
                allowInputConnected = true;
              };
              topology = {
                addresses = [
                  "172.16.2.3"
                ];
                connections = [
                  {
                    to = "kenobi";
                    iface = "wl-public";
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
