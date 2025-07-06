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
      wait-online = {
        extraArgs = [
          "--interface"
          lanDevice
        ];
      };
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
            # DNS Port
            53
            # HTTP(s) Ports
            80
            443
          ];
          allowedUDPPorts = [
            # DNS Port
            53
            # DHCP Port
            67
          ];
        };
      };
    };

    nftables = {
      ruleset = builtins.readFile ./config.nftables;
    };
  };
}
