{config, ...}: let
  netName = "tun-illyse";
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
          netName
        ];
      };
    };
  };

  networking = {
    firewall = {
      interfaces = {
        ${netName} = {
          allowedTCPPorts = [
            53 # DNS
            80 # HTTP
            443 # HTTPs
          ];
          allowedUDPPorts = [
            53 # DNS
          ];
        };
      };
    };

    nftables = {
      ruleset = builtins.readFile ./config.nftables;
    };
  };
}
