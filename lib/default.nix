self: lib: let
  mkImap = domain: conn_type: {
    port =
      if conn_type == "SSL/TLS"
      then 993
      else 143;
    tls =
      if conn_type == "SSL/TLS"
      then {
        enable = true;
      }
      else {
        useStartTls = true;
      };
    host = domain;
  };

  mkSmtp = domain: conn_type: {
    port =
      if conn_type == "SSL/TLS"
      then 465
      else 587;
    tls =
      if conn_type == "SSL/TLS"
      then {
        enable = true;
      }
      else {
        useStartTls = true;
      };
    host = domain;
  };

  mkImportCfg = type: typeCfg: hm:
    import ./${type}.nix {
      inherit lib hm;
      ${type} = typeCfg;
    };

  getValidHosts =
    builtins.filter (host: (
      builtins.pathExists ../machines/${host}/default.nix
    )) (
      builtins.filter (host: (
        # Ignore folders machines/_*
        builtins.match "_.*" host != []
      )) (lib.listDirs ../machines)
    );

  listSymlinks = inode:
    builtins.map (elem: elem.name) (
      builtins.filter (inode: inode.value == "symlink") (
        builtins.map (key: {
          name = key;
          value = builtins.getAttr key (builtins.readDir inode);
        })
        (builtins.attrNames (builtins.readDir inode))
      )
    );

  mkWgNetworkClient = routerName: wgNetworks: id: config:
    builtins.foldl' (acc: elem:
      {
        ${elem.name} = let
          routerNet = self.nixosConfigurations.${routerName}.config.systemd.network;
          port = builtins.toString routerNet.netdevs.${elem.name}.wireguardConfig.ListenPort;
          ip = builtins.concatStringsSep "" (
            builtins.elemAt (
              builtins.split "(.*)/.*" (
                builtins.elemAt routerNet.networks.${elem.name}.address 0
              )
            )
            1
          );
          prefix = builtins.concatStringsSep "" (
            builtins.elemAt (
              builtins.split "(.*)\.[0-9]{1,3}/.*" (
                builtins.elemAt routerNet.networks.${elem.name}.address 0
              )
            )
            1
          );
        in {
          inherit (elem) interface;
          address = lib.mkIf (elem ? address) elem.address;
          gateway = lib.mkIf (elem ? gateway) elem.gateway;
          routes = lib.mkIf (elem ? routes) elem.routes;
          networkConfig = lib.mkIf (elem ? networkConfig) elem.networkConfig;
          dns = [ip];
          networkCIDRPrefix = prefix;
          activationPolicy =
            if elem ? activationPolicy
            then elem.activationPolicy
            else "down";
          allowedTCPPorts = lib.mkIf (elem ? allowedTCPPorts) elem.allowedTCPPorts;
          allowedUDPPorts = lib.mkIf (elem ? allowedUDPPorts) elem.allowedUDPPorts;
          nftables = {
            allowNat = lib.mkIf (elem ? allowNat) elem.allowNat;
            allowInput = lib.mkIf (elem ? allowInput) elem.allowInput;
            allowInputConnected = lib.mkIf (elem ? allowInputConnected) elem.allowInputConnected;
            forward = {
              bidirectional = lib.mkIf (elem ? forward.bidirectional) elem.forward.bidirectional;
              outputInterfaces = lib.mkIf (elem ? forward.outputInterfaces) elem.forward.outputInterfaces;
              inputInterfaces = lib.mkIf (elem ? forward.inputInterfaces) elem.forward.inputInterfaces;
            };
          };
          wireguard = {
            inherit id;
            enable = true;
            privateKeyFile = config.sops.secrets."network/${elem.name}/private-key".path;
            peers =
              if (elem ? peers && elem.peers != [])
              then elem.peers
              else [
                {
                  Endpoint = "${elem.endpoint}:${port}";
                  PublicKey = ../machines/${routerName}/networks/wg-servers/_keys/${elem.name}.pub;
                  AllowedIPs = elem.allowedIPs;
                }
              ];
          };
          topology = {
            connections = [
              {
                to = "${routerName}";
                iface = elem.name;
                reversed = true;
              }
            ];
          };
        };
      }
      // acc) {}
    wgNetworks;

  mkWgNetworkServer = routerName: wgNetworks: config:
    builtins.foldl' (acc: elem:
      {
        ${elem.name} = {
          inherit (elem) interface;
          dns = [
            "${elem.CIDRPrefix}.${toString elem.id}"
          ];
          networkCIDRPrefix = elem.CIDRPrefix;
          networkCIDRLength = elem.CIDRLength;
          activationPolicy = "up";
          allowedTCPPorts = lib.mkIf (elem ? allowedTCPPorts) elem.allowedTCPPorts;
          allowedUDPPorts =
            (
              if (elem ? allowedUDPPorts)
              then elem.allowedUDPPorts
              else []
            )
            ++ [elem.listenPort];
          isServer = true;
          nftables = {
            allowNat = lib.mkIf (elem ? allowNat) elem.allowNat;
            allowInput = lib.mkIf (elem ? allowInput) elem.allowInput;
            allowInputConnected = lib.mkIf (elem ? allowInputConnected) elem.allowInputConnected;
            forward = {
              bidirectional = lib.mkIf (elem ? forward.bidirectional) elem.forward.bidirectional;
              outputInterfaces = lib.mkIf (elem ? forward.outputInterfaces) elem.forward.outputInterfaces;
              inputInterfaces = lib.mkIf (elem ? forward.inputInterfaces) elem.forward.inputInterfaces;
            };
          };
          wireguard = {
            inherit
              (elem)
              id
              listenInterfaces
              listenPort
              peers
              ;
            enable = true;
            privateKeyFile = config.sops.secrets."network/${elem.name}/private-key".path;
          };
          topology =
            {
              inherit (elem) color;
            }
            // (
              if (elem ? desc)
              then {inherit (elem) desc;}
              else {}
            );
        };
      }
      // acc) {}
    wgNetworks;
in {
  inherit
    listSymlinks
    getValidHosts
    mkImap
    mkSmtp
    mkImportCfg
    mkWgNetworkClient
    mkWgNetworkServer
    ;
}
