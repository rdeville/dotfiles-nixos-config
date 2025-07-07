{...}: let
  network = "enp1s0";
in {
  systemd = {
    network = {
      wait-online = {
        extraArgs = [
          "--interface"
          network
        ];
      };
      networks = {
        ${network} = {
          enable = true;
          matchConfig = {
            Name = network;
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
        ${network} = {
          allowedTCPPorts = [
            22 # SSH
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
