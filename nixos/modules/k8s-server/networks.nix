{
  self,
  config,
  lib,
  ...
}: let
  cfg = config.k8s-server;

  k8sPorts = import ../../../common/config/k8s.nix {inherit config;};
  routerNetwork = self.nixosConfigurations.kenobi.config.os.flavors.network.networks;

  wgNetworks = [
    (let
      name = "wg-private";
      prefix = "172.18.${cfg.envID}";
    in {
      inherit name;
      interface = name;
      activationPolicy = "up";
      endpoint = cfg.wireguard.endpoint;
      allowedIPs = "${prefix}.0/${routerNetwork.${name}.networkCIDRLength}";
      allowedTCPPorts = config.services.openssh.ports;
      allowInput = true;
      address = [
        "${prefix}.${toString cfg.id}/32"
      ];
      routes = [
        {
          Destination = routerNetwork.${name}.networkCIDR;
        }
      ];
    })
    (let
      name = "wg-k8s-${cfg.env}";
    in {
      inherit name;
      inherit
        (k8sPorts)
        allowedUDPPorts
        ;
      interface = name;
      activationPolicy = "up";
      endpoint = cfg.wireguard.endpoint;
      allowedIPs = routerNetwork.${name}.networkCIDR;
      allowedTCPPorts =
        k8sPorts.allowedTCPPorts;
      allowInput = true;
      forward = {
        outputInterfaces =
          [
            "cilium_wg0"
            "cilium_host"
          ] ++ cfg.wireguard.outputInterfaces;
        inputInterfaces = [
          "lxc*"
        ] ++ cfg.wireguard.inputInterfaces;
      };
      routes = [
        {
          Destination = routerNetwork.${name}.networkCIDR;
        }
      ];
    })
  ];
in {
  config = lib.mkIf cfg.enable {
    sops = {
      secrets = builtins.foldl' (acc: elem:
        {
          "network/${elem.name}/private-key" = {
            sopsFile = cfg.hostKeyDir + "/${elem.name}.private.key.enc.txt";
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
          firewall = {
            inherit (cfg.network) debug;
            inherit (k8sPorts) trustedInterfaces;
            enable = cfg.network.enableFirewall;
            checkReversePath = false;
          };
          nftables = {
            inherit (cfg.network) debug;
            enable = cfg.network.enableNftable;
          };
          networks = lib.mkWgNetworkClient "kenobi" wgNetworks cfg.id config;
        };
      };
    };
  };
}
