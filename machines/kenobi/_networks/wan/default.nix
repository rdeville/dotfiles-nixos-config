{...}: let
  lanDevice = "enp1s0";
  lanIface = lanDevice;
in {
  sops = {
    secrets = {
      "wireless/public/password" = {
        sopsFile = ../../secrets.enc.yaml;
      };
    };
  };

  networking = {
    # Physical and virtual Interface
    interfaces = {
      ${lanIface} = {
        device = lanDevice;
        useDHCP = true;
      };
    };

    firewall = {
      interfaces = {
        "${lanIface}" = {
          allowedTCPPorts = [
            # SSH Port
            22
            # DNS Port
            53
          ];
          allowedUDPPorts = [
            # DHCP Port
            67
            # DNS Port
            53
          ];
        };
      };
    };

    nftables = {
      ruleset = builtins.readFile ./config.nftables;
    };
  };
}
