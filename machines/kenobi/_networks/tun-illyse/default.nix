{config, ...}: {
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

  networking = {
    firewall = {
      interfaces = {
        tun-illyse = {
          allowedTCPPorts = [
            # SSH Port
            22
            # DNS Port
            53
            # HTTP(s) Ports
            80
            443
          ];
          allowedUDPPorts = [
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
