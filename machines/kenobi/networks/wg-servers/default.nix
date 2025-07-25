# Sources :
# https://labs.quansight.org/blog/2020/07/nixos-rpi-wifi-router
# https://www.jjpdev.com/posts/home-router-nixos/
{
  config,
  lib,
  ...
}: let
  id = 1;

  dnsPorts = [
    53 # DNS
  ];

  listenInterfaces = [
    "wg-private"
    "wg-tun-illyse"
  ];

  wg-k8s = (
    let
      clusters = [
        {
          name = "wg-k8s-prd";
          id = 128;
          topology = {
            color = "#8ec5ff";
            desc = "Wireguard k8s Production";
          };
          listenInterfaces =
            listenInterfaces
            ++ [
              "enp3s0"
              "vm-k8s-prd"
            ];
        }
        {
          name = "wg-k8s-stg";
          id = 144;
          topology = {
            color = "#2b7fff";
            desc = "Wireguard k8s Staging";
          };
          listenInterfaces =
            listenInterfaces
            ++ [
              "enp3s0"
              "k8s-stg"
              "vm-k8s-stg"
            ];
        }
        {
          name = "wg-k8s-dev";
          id = 160;
          topology = {
            color = "#1447e6";
            desc = "Wireguard k8s Development";
          };
          listenInterfaces =
            listenInterfaces
            ++ [
              "vm-k8s-dev"
            ];
        }
      ];
    in
      builtins.foldl' (acc: elem:
        [
          {
            inherit id;
            inherit (elem) name listenInterfaces;
            inherit (elem.topology) color desc;
            CIDRPrefix = "172.30.${toString elem.id}";
            CIDRLength = "24";
            listenPort = 65000 + elem.id;

            allowInput = true;
            allowInputConnected = true;
            allowBidirectional = true;
            allowedTCPPorts = dnsPorts;
            allowedUDPPorts = dnsPorts;

            peers = import ./${elem.name}.peers.nix;
          }
        ]
        ++ acc) []
      clusters
  );
  wgNetworks = let
    tunInterfaces = [
      "wg-tun-illyse"
    ];
  in
    [
      {
        inherit id tunInterfaces;
        listenInterfaces = [
          "wg-tun-illyse"
        ];
        name = "wg-public";
        CIDRPrefix = "172.17.0";
        CIDRLength = "16";
        listenPort = 60001;

        allowInputConnected = true;
        allowBidirectional = true;
        allowedTCPPorts = dnsPorts;
        allowedUDPPorts = dnsPorts;
        peers = import ./wg-public.peers.nix;

        desc = "Wireguard Public";
        color = "#c27aff";
      }
      {
        inherit id;
        listenInterfaces = [
          "wg-tun-illyse"
          "vm-k8s-dev"
          "vm-k8s-stg"
          "vm-k8s-prd"
          "enp3s0"
          "k8s-stg"
          "k8s-prd"
        ];
        name = "wg-private";
        CIDRPrefix = "172.18.0";
        CIDRLength = "16";
        listenPort = 61001;

        allowInput = true;
        allowBidirectional = true;
        allowedTCPPorts = config.services.openssh.ports ++ dnsPorts;
        allowedUDPPorts = dnsPorts;

        peers = import ./wg-private.peers.nix;
        color = "#fb2c36";
        desc = "Wireguard Private";
      }
    ]
    ++ wg-k8s;
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
        networks = lib.mkWgNetworkServer config.os.hostName wgNetworks config;
      };
    };
  };
}
