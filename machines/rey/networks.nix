{
  self,
  config,
  lib,
  ...
}: let
  id = 3;

  routerName = "kenobi";
  endpoint = [
    "89.234.140.170" # External Endpoint
    "172.16.1.1" # Ethernet Endpoint
    "172.16.2.1" # Wifi Endpoint
  ];

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
        # {
        #   name = "wg-k8s-dev";
        #   id = 160;
        #   color = "#1447e6";
        # }
      ];
    in
      builtins.foldl' (acc: elem:
        [
          {
            inherit (elem) name;
            interface = elem.name;
            endpoint = wgEndpoint;
            allowInputConnected = true;
            peers =
              builtins.map (
                endpoint: let
                  routerNet = self.nixosConfigurations.${routerName}.config.systemd.network;
                  port = builtins.toString routerNet.netdevs.${elem.name}.wireguardConfig.ListenPort;
                in {
                  Endpoint = "${endpoint}:${port}";
                  PublicKey = ../../machines/${routerName}/networks/wg-servers/_keys/${elem.name}.pub;
                  AllowedIPs = routerNetwork.${elem.name}.networkCIDR;
                }
              )
              endpoint;
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
        interface = "wg-public";
        endpoint = wgEndpoint;
        allowedIPs = "0.0.0.0/0";
        routes = [
          {
            Destination = "0.0.0.0/0";
          }
        ];
        allowNat = true;
        allowInputConnected = true;
        forward = {
          outputInterfaces = [
            "wlp170s0"
          ];
        };
        networkConfig = {
          IPMasquerade = "ipv4";
          IPv4Forwarding = true;
        };
      }
      (let
        name = "wg-private";
      in {
        inherit name;
        interface = name;
        endpoint = wgEndpoint;
        allowInput = true;
        allowedTCPPorts = config.services.openssh.ports;
        peers =
          builtins.map (
            endpoint: let
              routerNet = self.nixosConfigurations.${routerName}.config.systemd.network;
              port = builtins.toString routerNet.netdevs.${name}.wireguardConfig.ListenPort;
            in {
              Endpoint = "${endpoint}:${port}";
              PublicKey = ../../machines/${routerName}/networks/wg-servers/_keys/${name}.pub;
              AllowedIPs = routerNetwork.${name}.networkCIDR;
            }
          )
          endpoint;
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
        firewall = {
          trustedInterfaces = [
            "virbr*"
          ];
          debug = true;
        };
        nftables = {
          debug = true;
          extraInputRules = ''
            iifname { "virbr*" } accept comment "Allow Vagrant bridge."
          '';
          extraForwardRules = ''
            iifname { "virbr*" } oifname { "virbr*", "wlp*", "eth*" } accept comment "Allow Kind bridge."
            iifname { "virbr*", "wlp*", "eth*" } oifname { "virbr*" } ct state { established, related } accept comment "Allow if connection is already established"
          '';
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
                allowNat = true;
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
            eth-public = {
              interface = "eth*";
              matchConfig = {
                name = "en*";
              };
              DHCP = "yes";
              activationPolicy = "up";
              requiredForOnline = "no";
              nftables = {
                allowNat = true;
                allowInputConnected = true;
              };
              topology = {
                addresses = [
                  "172.16.1.3"
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

  networking = {
    nat = {
      enable = true;
      internalIPs = [
        "192.168.121.0/24"
      ];
    };
  };
}
