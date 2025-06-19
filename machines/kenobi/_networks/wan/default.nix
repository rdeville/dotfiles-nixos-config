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

  systemd = {
    network = {
      networks = {
        "1000-${lanIface}" = {
          enable = true;
          matchConfig = {
            Name = lanIface;
          };
          networkConfig = {
            DHCP = "ipv4";
            IPv6AcceptRA = false;
          };
          linkConfig = {
            RequiredForOnline = "routable";
          };
        };
      };
    };
  };

  networking = {
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
