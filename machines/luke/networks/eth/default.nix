{lib, ...}: let
  netName = "enp1s0";
in {
  systemd = {
    network = {
      enable = true;
      networks = {
        "${netName}" = {
          matchConfig = {
            Name = netName;
          };
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
      enable = true;
      allowedUDPPorts = [];
      allowedTCPPorts = [];
    };

    nftables = {
      enable = lib.mkForce false;
      # ruleset = builtins.readFile ./config.nftables;
    };
  };
}
