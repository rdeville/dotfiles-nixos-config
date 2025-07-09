{...}: let
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
            "${prefix}.201/32"
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
    firewall = {
      enable = true;
      allowedTCPPorts = [
        22 # SSH
      ];
      allowedUDPPorts = [];
    };

    nftables = {
      enable = true;
      ruleset = builtins.readFile ./config.nftables;
    };
  };
}
