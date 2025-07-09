{config, ...}: let
  vmName = "vm-${parentName}-${builtins.baseNameOf ../.}";
  netName = "vm-${builtins.baseNameOf ../.}";
  parentName = config.os.hostName;
  prefix = "172.20.128";
  length = "24";
  cidr = "${prefix}.0/${length}";
in {
  systemd = {
    tmpfiles = {
      rules = [
        # Create folder needed for VM volumes
        "d /var/lib/microvms/${vmName}/var 0755 microvm kvm -"
        "d /var/lib/microvms/${vmName}/volumes 0755 microvm kvm -"
        "d /var/lib/microvms/${vmName}/var/log 0755 microvm systemd-journal -"
        # Creates a symlink of each MicroVM's journal under the host's /var/log/journal
        "L+ /var/log/journal/${vmName} - - - - /var/lib/microvms/${vmName}/var/log/journal"
      ];
    };
  };

  systemd = {
    network = {
      networks = {
        ${netName} = {
          matchConfig = {
            Name = netName;
          };
          address = [
            "${prefix}.1/32"
          ];
          routes = [
            {
              Destination = "${cidr}";
            }
          ];
          DHCP = "no";
          networkConfig = {
            IPv4Forwarding = true;
          };
          linkConfig = {
            RequiredForOnline = "no";
          };
        };
      };
    };
  };

  networking = {
    firewall = {
      enable = true;
      interfaces = {
        ${netName} = {
          allowedTCPPorts = [
            53 # DNS
          ];
          allowedUDPPorts = [
            53 # DNS
            65128 # Wireguard k8s-prd
          ];
        };
      };
    };

    nat = {
      enable = true;
      internalIPs = [
        cidr
      ];
    };

    nftables = {
      enable = true;
      ruleset = builtins.readFile ./config.nftables;
    };
  };
}
