{lib, ...}: let
  mac = "02:00:00:00:00:a0";
  netName = "vm-${builtins.baseNameOf ../../.}";
  prefix = "172.20.160";
in {
  microvm = {
    interfaces = [
      {
        type = "tap";
        id = netName;
        inherit mac;
      }
    ];
  };

  systemd = {
    network = {
      enable = true;
      networks = {
        "10-${netName}" = {
          matchConfig = {
            MACAddress = mac;
          };
          # Static IP configuration
          address = [
            "${prefix}.203/32"
          ];
          routes = [
            {
              # A route to the host
              Destination = "${prefix}.0/32";
              GatewayOnLink = true;
            }
            {
              # Default route
              Destination = "0.0.0.0/0";
              Gateway = "${prefix}.1";
              GatewayOnLink = true;
            }
          ];
          networkConfig = {
            # DNS servers no longer come from DHCP nor Router
            # Advertisements. Perhaps you want to change the defaults:
            DNS = [
              "89.234.140.170"
            ];
          };
        };
      };
    };
  };

  networking = {
    enableIPv6 = false;
    firewall = {
      enable = lib.mkForce false;
      allowPing = true;
      allowedUDPPorts = [];
      #   # Cilium Port
      #   # See: https://docs.cilium.io/en/stable/operations/system_requirements/
      #   # Wireguard
      #   51871
      # ];
      allowedTCPPorts = [];
      #   # Kube API
      #   6443
      #   # Cilium Port
      #   # See: https://docs.cilium.io/en/stable/operations/system_requirements/
      #   # Cilium health
      #   4240
      #   # Cilium metrics
      #   10250
      #   # Hubble metrics
      #   9965
      #   # Hubble peer
      #   4244
      # ];
      # # See: https://github.com/cilium/cilium/issues/27900#issuecomment-2572253315
      # trustedInterfaces = [
      #   "cilium_net*"
      #   "cilium_host*"
      #   "cilium_vxlan"
      #   "lxc*"
      # ];
    };

    nftables = {
      enable = lib.mkForce false;
      # ruleset = builtins.readFile ./config.nftables;
    };
  };
}
