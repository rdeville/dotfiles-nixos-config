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

  netNat = builtins.filter (
    name:
      cfg.networks.${name}.nftables.allowNat
  ) (builtins.attrNames cfg.networks);

  inputRules = [
    (
      (
        if (netInput != [])
        then ''
          # Inputs
          iifname { ${builtins.concatStringsSep "," netInput} } accept comment "Allow local access from this network"
        ''
        else ""
      )
      + (
        if (netInputConnected != [])
        then ''
          # Inputs connected
          iifname { ${builtins.concatStringsSep "," netInputConnected} } ct state { established, related } accept comment "Allow if connection is already established"
        ''
        else ""
      )
      + (
        if (cfg.firewall.trustedInterfaces != [])
        then ''
          # Trusted
          iifname { "lo", ${builtins.concatStringsSep "," cfg.firewall.trustedInterfaces} } accept comment "Trusted Interfaces"
        ''
        else ''
          # Trusted
          iifname { lo } accept comment "Allow local access from this network"
        ''
      )
    )
  ];

  forwardRules = builtins.foldl' (acc: elem: let
    inherit (cfg.networks.${elem}) interface;
    nftables = cfg.networks.${elem}.nftables.forward;
    rules =
      (
        if nftables.bidirectional
        then ''
          # Bidirectional
          iifname { "${interface}" } oifname { "${interface}" } accept comment "Allow bidirection forward on this network"
        ''
        else ""
      )
      + (
        if nftables.outputInterfaces != []
        then ''
          # Output
          iifname { "${interface}" } oifname { "${builtins.concatStringsSep "\", \"" nftables.outputInterfaces}" } accept comment "Allow forward to these output interface"
          iifname { "${builtins.concatStringsSep "\", \"" nftables.outputInterfaces}" } oifname { "${interface}" } ct state { established, related } accept comment "Allow if connection is already established"
        ''
        else ""
      )
      + (
        if nftables.inputInterfaces != []
        then ''
          # Input
          iifname { "${builtins.concatStringsSep "\", \"" nftables.inputInterfaces}" } oifname { "${interface}" } accept comment "Allow forward to these input interface"
          iifname { "${interface}" } oifname { "${builtins.concatStringsSep "\", \"" nftables.inputInterfaces}" } ct state { established, related } accept comment "Allow if connection is already established"
        ''
        else ""
      );
    content =
      if rules != ""
      then ''
        # ${interface} Rules
        ${rules}
      ''
      else "";
  in
    [
      content
    ]
    ++ acc) [] (builtins.attrNames cfg.networks);
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

          topology = {
            enable = lib.mkEnableOption "Enable topology globally for networks";
          };

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

          nftables = {
            enable = lib.mkDefaultEnabledOption "Enable nftables";
            debug = lib.mkEnableOption "Enable nftrace for all table, chain and hook";
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
            extraInputRules = lib.mkOption {
              type = lib.types.lines;
              default = "";
              description = ''
                Contents of the rule to add to chain input.
              '';
            };
            extraForwardRules = lib.mkOption {
              type = lib.types.lines;
              default = "";
              description = ''
                Contents of the rule to add to chain forward.
              '';
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
      dhcpcd = {
        enable = cfg.useDHCP;
      };
    };

    systemd = {
      network = {
        enable = true;
        # Force links to empty to avoid auto-configuration of interface if
        # facter detect VPN interfaces
        links = lib.mkForce {};

        networks = builtins.foldl' (acc: name: let
          interface = cfg.networks.${name};
        in
          {
            "10-${name}" = {
              inherit
                (interface)
                enable
                dns
                domains
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
                Unmanaged = interface.unmanaged;
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
          (cfg.nftables)
          enable
          flushRuleset
          ;

        tables =
          {
            os-monitor-all = lib.mkIf cfg.nftables.debug {
              family = "inet";
              content = ''
                chain prerouting {
                  type filter hook prerouting priority -350; policy accept;
                  meta nftrace set 1;
                }
              '';
            };
            os-drop-ipv6 = {
              family = "ip6";
              content =
                lib.strings.concatMapStrings (chain: ''
                  chain ${chain} {
                      type filter hook ${chain} priority 99; policy ${cfg.nftables.defaultPolicy};
                      counter drop comment "Drop IPv6 traffic"
                    }
                '')
                nftablesChains;
            };
            os-allow = {
              family = "inet";
              content = ''
                chain input {
                  type filter hook input priority 0; policy ${cfg.nftables.defaultPolicy};
                  ${lib.strings.concatStrings inputRules}
                  ${cfg.nftables.extraInputRules}
                }

                chain forward {
                  type filter hook forward priority 0; policy ${cfg.nftables.defaultPolicy};
                  ${lib.strings.concatStrings forwardRules}
                  ${cfg.nftables.extraForwardRules}
                }
              '';
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
          // cfg.nftables.extraTables;
      };
    };

    topology = {
      self = {
        name = config.os.hostName;
        interfaces = builtins.foldl' (acc: elem: let
          iface = config.os.flavors.network.networks.${elem};
          realIface = iface.interface;
          portTCP = lib.lists.unique ((
              config.networking.firewall.interfaces.${realIface}.allowedTCPPorts or []
            )
            ++ (
              config.networking.firewall.interfaces.${elem}.allowedTCPPorts or []
            ));
          portUDP = lib.lists.unique (
            (
              config.networking.firewall.interfaces.${realIface}.allowedUDPPorts or []
            )
            ++ (
              config.networking.firewall.interfaces.${elem}.allowedUDPPorts or []
            )
          );
        in
          {
            ${iface.topology.name} = {
              mac = lib.mkForce (
                let
                  portsTCP =
                    if portTCP == []
                    then ""
                    else "TCP: ${builtins.concatStringsSep "," (
                      builtins.map toString portTCP
                    )}";
                  portsUDP =
                    if portUDP == []
                    then ""
                    else "UDP: ${builtins.concatStringsSep "," (
                      builtins.map toString portUDP
                    )}";
                in
                  if portsTCP != "" && portsUDP != ""
                  then "${portsTCP}; ${portsUDP}"
                  else if portsTCP != "" && portsUDP == ""
                  then "${portsTCP}"
                  else if portsTCP == "" && portsUDP != ""
                  then "${portsUDP}"
                  else ""
              );
              addresses = cfg.networks.${elem}.topology.addresses or [];
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
        services =
          if config.services.k3s.enable
          then {
            k3s = let
              inherit (config.services) k3s;
              server =
                if k3s.role == "server"
                then true
                else false;
              agent =
                if (k3s.role == "agent" || (k3s.role == "server" && ! k3s.disableAgent))
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
          else {};
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
                  inherit
                    (net)
                    wireguard
                    vlan
                    ;
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
  #);
}
