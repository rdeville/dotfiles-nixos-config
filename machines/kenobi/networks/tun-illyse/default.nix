{config, ...}: let
  vpnIface = "tun-illyse";
in {
  sops = {
    secrets = {
      "illyse-vpn-password" = {
        sopsFile = ./creds.enc.yaml;
        key = "password";
      };
    };
    templates = {
      "openvpn-illyse-creds" = {
        content = ''
          rdeville-vpn1
          ${config.sops.placeholder.illyse-vpn-password}
        '';
      };
    };
  };

  environment = {
    etc = {
      "openvpn/creds/illyse" = {
        source = config.sops.templates.openvpn-illyse-creds.path;
      };
    };
  };

  services = {
    fail2ban = {
      enable = true;
    };

    openvpn = {
      servers = {
        "illyse" = {
          config = builtins.readFile ./illyse.conf;
        };
      };
    };
  };

  systemd = {
    network = {
      wait-online = {
        extraArgs = [
          "--interface"
          vpnIface
        ];
      };
    };
  };

  networking = {
    firewall = {
      interfaces = {
        "${vpnIface}" = {
          allowedTCPPorts = [
            # DNS Port
            53
            # DHCP Port
            67
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
