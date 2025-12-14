{
  config,
  lib,
  name,
  ...
}: let
  cfg = config;
in {
  options = {
    enable = lib.mkDefaultEnabledOption "Enable interface";

    name = lib.mkOption {
      type = lib.types.str;
      description = "This network interface.";
      default = name;
      readOnly = true;
    };

    interface = lib.mkOption {
      type = lib.types.str;
      description = ''
        Name of the real interface to apply for firewall or nftable.
      '';
    };

    isServer = lib.mkEnableOption ''
      Specify if network is provided by a server.
    '';

    DHCP = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      description = ''Specify if network use dhcp.'';
      default = null;
    };

    networkConfig = lib.mkOption {
      type = lib.types.attrs;
      description = ''
        Content of networkConfig for systemd-networkd
      '';
      default = {};
    };

    address = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      description = ''List of IPs addresses to assign to the network'';
      default = [];
    };

    gateway = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      description = ''List of IPs gateway to assign to the network'';
      default = [];
    };

    routes = lib.mkOption {
      type = lib.types.listOf lib.types.attrs;
      description = ''
        List of routes to add to the network
      '';
      default = [];
    };

    nftables = {
      allowNat = lib.mkEnableOption ''
        Allow nat from the network.
      '';

      allowInput = lib.mkEnableOption ''
        Allow other machines on this network to communicate with the machine.
      '';

      allowInputConnected = lib.mkEnableOption ''
        Allow packet from connected comlunication on input chain.
      '';

      forward = {
        bidirectional = lib.mkEnableOption ''
          Allow bidirectional communication within the network.
        '';

        outputInterfaces = lib.mkOption {
          type = lib.types.listOf lib.types.str;
          description = ''
            List of tunnel interfaces to which allow forward traffic.
          '';
          default = [];
        };

        inputInterfaces = lib.mkOption {
          type = lib.types.listOf lib.types.str;
          description = ''
            List of tunnel interfaces to which allow forward traffic.
          '';
          default = [];
        };
      };

      extraTables = lib.mkOption {
        type = lib.types.attrsOf lib.types.attrs;
        description = ''
          Table to add to nftable configuration, see NixOS documentation
          to know structures.
        '';
        default = {};
      };
    };

    networkCIDRPrefix = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      description = ''
        IP prefix of the network hosted by interface of the form `X.Y.Z`.
        Omit the last value of the IP since it will be computed from
        the attribute `networkID`.
      '';
      default = null;
    };

    networkCIDRLength = lib.mkOption {
      type = lib.types.str;
      description = ''
          Length of the CIDR hosted by the interface network.
          CIDR will automatically be computed from the attribute
        `networkCIDRPrefix` with the for
        `''${networkCIDRPrefix}.O/''${networkCIDRLength}`
      '';
      default = "24";
    };

    networkCIDR = lib.mkOption {
      type = lib.types.str;
      readOnly = true;
      description = ''
        Computed values of the CIDR of the interface network
      '';
      default =
        if cfg.DHCP == null && cfg.networkCIDRPrefix != null
        then "${cfg.networkCIDRPrefix}.0/${cfg.networkCIDRLength}"
        else "";
    };

    allowedTCPPorts = lib.mkOption {
      type = lib.types.listOf lib.types.int;
      description = "List of port to open on interface.";
      default = [];
    };

    allowedUDPPorts = lib.mkOption {
      type = lib.types.listOf lib.types.int;
      description = "List of port to open on interface.";
      default = [];
    };

    dns = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      description = "List of IPs for DNS server for this network";
      default = [];
    };

    domains = lib.mkOption {
      type = lib.types.nullOr (lib.types.listOf lib.types.str);
      description = ''
        List of domains for which DNS requests will be done through
        this interface
      '';
      default = null;
    };

    addresses = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      description = "List of IPs for this network";
      default = [];
    };

    matchConfig = {
      mac = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        description = "Mac address of the interface";
        default = null;
      };
      name = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        description = "Name of the network";
        default = null;
      };
    };

    mtu = lib.mkOption {
      type = lib.types.int;
      description = "MTUBytes to set for interface config.";
      default = 1500;
    };

    activationPolicy = lib.mkOption {
      type = lib.types.enum ["up" "down"];
      description = ''
        Activation policy for this interface, either `up` or `down`.
      '';
      default = "down";
    };

    requiredForOnline = lib.mkOption {
      type = lib.types.str;
      description = ''
        Specify state of interface for systemd-network-wait-online service.

        See [following manpage](https://www.mankier.com/5/systemd.network#%5BLink%5D_Section_Options-RequiredForOnline)
        for more information.
      '';
      default = "no";
    };

    unmanaged = lib.mkOption {
      type = lib.types.enum ["yes" "no"];
      description = ''
        Takes a boolean (yes or no).
        When "yes", no attempts are made to bring
        up or configure matching links, equivalent to when there are no
        matching network files. Defaults to "no".
      '';
      default = "no";
    };

    wireguard = lib.mkOption {
      type = lib.types.submodule (import ./wireguard/options.nix);
      description = "Wireguard configuration for this network";
      default = {};
    };

    vlan = lib.mkOption {
      type = lib.types.submodule (import ./vlan/options.nix);
      description = "Vlan configuration for this network";
      default = {};
    };

    topology = {
      enable = lib.mkDefaultEnabledOption ''
        Add nix-topology block to render network and connection when
        using nix-topology

        For more details about what is nix-topology, see :
          * https://oddlama.github.io/nix-topology/
      '';

      name = lib.mkOption {
        type = lib.types.str;
        description = "Name of the interface on the nix-topology render";
        default = cfg.name;
      };

      color = lib.mkOption {
        type = lib.types.str;
        description = ''
          If boolean `isServer` is set to true, a new topology
          network will be added.
          This attribute will set color to use for this network.
        '';
        default = "#ffffff";
      };

      desc = lib.mkOption {
        type = lib.types.str;
        description = ''
          If boolean `isServer` is set to true, define the net of
          the network that will be shown on the render topology.

          Default set to the network name.
        '';
        default = name;
      };

      netName = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        description = ''
          If boolean `isServer` is set to true, define the net of
          the network that will be shown on the render topology.

          Default set to the network name.
        '';
        default = null;
      };

      addresses = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        description = "List of addresses associated the interface";
        default = [];
      };

      connections = lib.mkOption {
        type = lib.types.listOf (lib.types.submodule {
          options = {
            to = lib.mkOption {
              type = lib.types.str;
              description = "Node to the connect to.";
            };

            iface = lib.mkOption {
              type = lib.types.str;
              description = "Interface of the desctinaion node to connect.";
            };

            reversed = lib.mkOption {
              type = lib.types.bool;
              description = "Wheither the set connection reversed";
              default = false;
            };
          };
        });
        description = ''Declare connections to show in topology rendering'';
        default = [];
      };
    };
  };
}
