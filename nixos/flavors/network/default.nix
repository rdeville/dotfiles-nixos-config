{
  config,
  lib,
  ...
}: let
  name = builtins.baseNameOf ./.;
  cfg = config.os.flavors.${name};

  nftablesChains = [
    "prerouting"
    "input"
    "forward"
    "output"
    "postrouting"
  ];

  netInput = builtins.map (name: cfg.networks.${name}.interface) (
    builtins.filter (
      name:
        cfg.networks.${name}.nftables.allowInput
    ) (builtins.attrNames cfg.networks)
  );

  netInputConnected = builtins.map (name: cfg.networks.${name}.interface) (
    builtins.filter (
      name:
        cfg.networks.${name}.nftables.allowInputConnected
    ) (builtins.attrNames cfg.networks)
  );

  netBidirectional = builtins.map (name: cfg.networks.${name}.interface) (
    builtins.filter (
      name:
        cfg.networks.${name}.nftables.allowBidirectional
    ) (builtins.attrNames cfg.networks)
  );

  netNat = builtins.filter (
    name:
      cfg.networks.${name}.nftables.allowNat
  ) (builtins.attrNames cfg.networks);

  tunInterfaces = builtins.foldl' (acc: elem:
    cfg.networks.${elem}.nftables.tunInterfaces
    ++ acc) []
  (builtins.attrNames cfg.networks);

  netTun = builtins.foldl' (acc: elem:
    {
      ${elem} =
        builtins.foldl' (acc: net:
          [cfg.networks.${net}.interface]
          ++ acc) []
        (
          builtins.filter (
            name: let
              tunInterfaces = cfg.networks.${name}.nftables.tunInterfaces;
            in
              tunInterfaces != [] && builtins.elem elem tunInterfaces
          )
          (builtins.attrNames cfg.networks)
        );
    }
    // acc) {}
  tunInterfaces;
in {
  imports = [
    ./wireguard
    ./vlan
  ];

  options = {
    os = {
      flavors = {
        ${name} = {
          enable = lib.mkEnableOption "Install ${name} NixOS flavors.";

          useDHCP = lib.mkEnableOption "Globally enable DHCP";
          useIPv6 = lib.mkEnableOption "Globall enable IPv6";

          firewall = {
            enable = lib.mkDefaultEnabledOption "Enable firewall";
            allowPing = lib.mkDefaultEnabledOption "Allow to ping";
            debug = lib.mkEnableOption ''
              Activate logging of refused packet, connection, etc.
              WARNING ! Can log lots of things
            '';
            checkReversePath = lib.mkOption {
              type = lib.types.either lib.types.bool (
                lib.types.enum [
                  "strict"
                  "loose"
                ]
              );
              description = ''
                Policy to apply to rpfilter.
                automatically set to "loose" if k3s service is enabled
              '';
              default =
                if config.services.k3s.enable
                then "loose"
                else true;
            };
            trustedInterfaces = lib.mkOption {
              type = lib.types.listOf lib.types.str;
              description = "List of trusted interfaces";
              default = [];
            };
          };

          nftable = {
            enable = lib.mkDefaultEnabledOption "Enable nftables";
            defaultPolicy = lib.mkOption {
              type = lib.types.enum ["drop" "accept"];
              description = "Activate default accept policy";
              default = "drop";
            };
            flushRuleset = lib.mkDefaultEnabledOption ''
              Enable Flush ruleset on reload
            '';
            extraTables = lib.mkOption {
              type = lib.types.attrsOf lib.types.attrs;
              description = ''
                Table to add to nftable configuration, see NixOS documentation
                to know structures.
              '';
              default = {};
            };
          };

          networks = lib.mkOption {
            description = "Configure wireguard interfaces.";
            default = {};
            type = lib.types.attrsOf (lib.types.submodule (import ./options.nix));
          };

          networkmanager = {
            enable = lib.mkEnableOption "Enable networkmanager";
          };

          nameservers = lib.mkOption {
            type = lib.types.listOf lib.types.str;
            description = ''
              List of nameservers to use globally
            '';
            default = [];
          };
        };
      };
    };
  };

  config = lib.mkIf cfg.enable {
    networking = {
      inherit (cfg) useDHCP;
    };

    systemd = {
      network = {
        networks = builtins.foldl' (acc: name: let
          interface = cfg.networks.${name};
        in
          {
            ${name} = {
              inherit
                (interface)
                enable
                dns
                DHCP
                address
                gateway
                routes
                ;

              matchConfig =
                (
                  if interface.matchConfig.mac != null
                  then {
                    MACAddress = interface.matchConfig.mac;
                  }
                  else {}
                )
                // (
                  if interface.matchConfig.name != null
                  then {
                    Name = interface.matchConfig.name;
                  }
                  else {
                    Name = interface.name;
                  }
                );
              networkConfig =
                {
                  IPv6AcceptRA = false;
                }
                // interface.networkConfig;
              linkConfig = {
                RequiredForOnline = interface.requiredForOnline;
                ActivationPolicy = interface.activationPolicy;
              };
            };
          }
          // acc) {} (builtins.attrNames cfg.networks);
      };
    };

    networking = {
      inherit (cfg) nameservers;

      networkmanager = {
        inherit (cfg.networkmanager) enable;
      };

      firewall = {
        inherit
          (cfg.firewall)
          enable
          allowPing
          checkReversePath
          trustedInterfaces
          ;
        logRefusedPackets = cfg.firewall.debug;
        logRefusedConnections = cfg.firewall.debug;
        logReversePathDrops = cfg.firewall.debug;
        # NO PORT GLOBALLY OPEN !
        allowedTCPPorts = [];
        allowedUDPPorts = [];
        interfaces = builtins.foldl' (acc: name: let
          interface = cfg.networks.${name};
        in
          {
            ${interface.interface} = {
              inherit
                (interface)
                allowedTCPPorts
                allowedUDPPorts
                ;
            };
          }
          // acc) {} (builtins.attrNames cfg.networks);
      };

      nftables = {
        inherit
          (cfg.nftable)
          enable
          flushRuleset
          ;

        tables =
          {
            os-monitor-all = {
              family = "inet";
              content =
                lib.strings.concatMapStrings (chain: ''
                  chain ${chain} {
                      type filter hook ${chain} priority -350; policy accept;
                      meta nftrace set 1;
                    }
                '')
                nftablesChains;
            };
            os-drop-ipv6 = {
              family = "ip6";
              content =
                lib.strings.concatMapStrings (chain: ''
                  chain ${chain} {
                      type filter hook ${chain} priority 99; policy ${cfg.nftable.defaultPolicy};
                      counter drop comment "Drop IPv6 traffic"
                    }
                '')
                nftablesChains;
            };
            os-allow = {
              family = "inet";
              content = lib.strings.concatStrings [
                (
                  let
                    input =
                      if (netInput != [])
                      then ''
                        iifname { ${builtins.concatStringsSep "," netInput} } accept comment "Allow local access from this network"
                      ''
                      else "";
                    inputConnected =
                      if (netInputConnected != [])
                      then ''
                        iifname { ${builtins.concatStringsSep "," netInputConnected} } ct state { established, related } accept comment "Allow if connection is already established"
                      ''
                      else "";
                    trusted =
                      if (cfg.firewall.trustedInterfaces != [])
                      then ''

                        iifname { ${builtins.concatStringsSep "," cfg.firewall.trustedInterfaces} } accept comment "Trusted Interfaces"
                      ''
                      else "";
                  in ''
                    chain input {
                      type filter hook input priority 0; policy ${cfg.nftable.defaultPolicy};
                      iifname { lo } accept comment "Allow local access from this network"
                      ${input}
                      ${trusted}
                      ${inputConnected}
                    }
                  ''
                )
                (
                  let
                    bidirection =
                      if (netBidirectional != [])
                      then
                        lib.strings.concatMapStrings (interface: ''
                          iifname { ${interface} } oifname { ${interface} } accept comment "Allow bidirection forward on this network"
                        '')
                        netBidirectional
                      else "";
                    tunnel =
                      if (netTun != {})
                      then
                        lib.strings.concatMapStrings (interface: ''
                          iifname { ${builtins.concatStringsSep "," netTun.${interface}} } oifname { ${interface} } accept comment "Allow forward from these network tunnel interface"
                          iifname { ${interface} } oifname { ${builtins.concatStringsSep "," netTun.${interface}} } ct state { established, related } accept comment "Allow if connection is already established"
                        '') (builtins.attrNames netTun)
                      else "";
                    trusted =
                      if (cfg.firewall.trustedInterfaces != [])
                      then
                        lib.strings.concatMapStrings (interface: ''
                          iifname {  ${builtins.concatStringsSep "," cfg.firewall.trustedInterfaces} } oifname { ${builtins.concatStringsSep "," netTun.${interface}} } accept comment "Allow forward from trusted interfaces"
                          iifname { ${builtins.concatStringsSep "," netTun.${interface}} } oifname { ${builtins.concatStringsSep "," cfg.firewall.trustedInterfaces} } ct state { established, related } accept comment "Allow back to trusted interfaces if connection is already established"
                        '') (builtins.attrNames netTun)
                      else "";
                  in ''
                    chain forward {
                      type filter hook forward priority 0; policy ${cfg.nftable.defaultPolicy};
                      ${trusted}
                      ${bidirection}
                      ${tunnel}
                    }
                  ''
                )
              ];
            };
            os-nat = lib.mkIf (netNat != []) {
              family = "inet";
              content = ''
                chain postrouting {
                    type nat hook postrouting priority 100; policy accept;
                    oifname { ${builtins.concatStringsSep "," netNat} } masquerade
                }
              '';
            };
          }
          // cfg.nftable.extraTables;
      };
    };

    topology = {
      self = {
        interfaces = builtins.foldl' (acc: elem: let
          iface = config.os.flavors.network.networks.${elem};
        in
          {
            ${iface.topology.name} = {
              mac = lib.mkForce (
                if iface.allowedTCPPorts == []
                then "No Open Ports"
                else "Ports: ${builtins.concatStringsSep "," (
                  builtins.map (port: toString port)
                  iface.allowedTCPPorts
                )}"
              );
              addresses =
                if cfg.networks.${elem}.topology ? addresses
                then cfg.networks.${elem}.topology.addresses
                else [];
              icon = let
                net = config.os.flavors.network.networks.${elem};
              in
                if net.vlan ? enable && net.vlan.enable
                then ../../../assets/images/interfaces/vlan.png
                else if net.wireguard ? enable && net.wireguard.enable
                then "interfaces.wireguard"
                else "interfaces.ethernet";
              physicalConnections = builtins.foldl' (acc: conn:
                if conn.reversed
                then [
                  (config.lib.topology.mkConnectionRev conn.to conn.iface)
                ]
                else
                  [
                    (config.lib.topology.mkConnection conn.to conn.iface)
                  ]
                  ++ acc) []
              cfg.networks.${elem}.topology.connections;
              network = lib.mkIf cfg.networks.${elem}.isServer elem;
            };
          }
          // acc) {} (builtins.attrNames cfg.networks);
        services = (
          if config.services.k3s.enable
          then {
            k3s = let
              k3s = config.services.k3s;
              server =
                if k3s.role == "server"
                then true
                else false;
              agent =
                if (k3s.role == "agent" || (k3s.role == "server" && k3s.disableAgent == false))
                then true
                else false;
              name = lib.concatStringsSep " " [
                "Kubernetes"
                (
                  if server
                  then "Control Plane"
                  else ""
                )
                (
                  if agent
                  then "Worker"
                  else ""
                )
              ];
            in {
              inherit name;
              icon = ../../../assets/images/services/kubernetes.png;
            };
          }
          else {}
        );
      };

      networks = builtins.foldl' (acc: elem:
        (
          if cfg.networks.${elem}.isServer
          then let
            net = cfg.networks.${elem};
            netName =
              if net.topology.netName != null
              then net.topology.netName
              else elem;
          in {
            ${netName} = {
              name = net.topology.desc;
              cidrv4 = net.networkCIDR;
              style = {
                primaryColor = net.topology.color;
                secondaryColor = null;
                pattern = let
                  wireguard = net.wireguard;
                  vlan = net.vlan;
                in
                  if (wireguard ? enable && wireguard.enable)
                  then "dotted"
                  else if (vlan ? enable && vlan.enable)
                  then "dashed"
                  else "solid";
              };
            };
          }
          else {}
        )
        // acc) {} (builtins.attrNames cfg.networks);
    };
  };
}
