{
  config,
  lib,
  ...
}: let
  cfg = config.os.flavors.network;

  wgNetwork = builtins.filter (
    elem:
      cfg.networks.${elem}.wireguard.enable
  ) (builtins.attrNames cfg.networks);

  allowedUDPPorts =
    builtins.foldl' (acc: name:
      {
        ${name} = {
          allowedUDPPorts = builtins.foldl' (acc: interface: let
            wgCfg = cfg.networks.${interface}.wireguard;
          in
            (
              if (builtins.elem name wgCfg.listenInterfaces)
              then [
                wgCfg.listenPort
              ]
              else []
            )
            ++ acc) []
          wgNetwork;
        };
      }
      // acc) {}
    (
      builtins.foldl' (acc: elem:
        cfg.networks.${elem}.wireguard.listenInterfaces
        ++ acc) []
      wgNetwork
    );
in {
  config = lib.mkIf (wgNetwork != []) {
    systemd = {
      network = {
        netdevs = builtins.foldl' (acc: name: let
          interface = cfg.networks.${name};
        in
          {
            "10-${name}" = {
              netdevConfig = {
                Kind = "wireguard";
                Name = name;
              };
              wireguardConfig = {
                ListenPort = interface.wireguard.listenPort;
                PrivateKeyFile = interface.wireguard.privateKeyFile;
              };
              wireguardPeers = builtins.map (
                peer:
                  if interface.isServer
                  then {
                    PublicKey =
                      if lib.isString peer.PublicKey
                      then peer.PublicKey
                      else
                        lib.removeSuffix "\n" (
                          builtins.readFile peer.PublicKey
                        );
                    AllowedIPs = peer.AllowedIPs;
                  }
                  else {
                    inherit (peer) Endpoint;
                    PublicKey =
                      if lib.isString peer.PublicKey
                      then peer.PublicKey
                      else
                        lib.removeSuffix "\n" (
                          builtins.readFile peer.PublicKey
                        );
                    AllowedIPs =
                      if peer ? AllowedIPs
                      then peer.AllowedIPs
                      else "${interface.networkCIDRPrefix}.${toString interface.wireguard.id}/32";
                    PersistentKeepalive = 30;
                  }
              ) (interface.wireguard.peers);
            };
          }
          // acc) {}
        wgNetwork;

        networks = builtins.foldl' (acc: name:
          (
            if cfg.networks.${name}.address == []
            then {
              "10-${name}" = {
                address =
                  if cfg.networks.${name}.isServer
                  then [
                    "${cfg.networks.${name}.networkCIDRPrefix}.1/${cfg.networks.${name}.networkCIDRLength}"
                  ]
                  else [
                    "${cfg.networks.${name}.networkCIDRPrefix}.${toString cfg.networks.${name}.wireguard.id}/32"
                  ];
              };
            }
            else {}
          )
          // acc) {}
        wgNetwork;
      };
    };

    networking = {
      firewall = {
        interfaces = allowedUDPPorts;
      };
      wireguard = {
        enable = true;
        useNetworkd = true;
      };
    };
  };
}
