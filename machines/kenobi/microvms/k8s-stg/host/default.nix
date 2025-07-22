{config, ...}: let
  parentName = config.os.hostName;
  vmName = "vm-${parentName}-${builtins.baseNameOf ../.}";
  netName = "vm-${builtins.baseNameOf ../.}";
  prefix = "172.20.144";
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

  os = {
    flavors = {
      network = {
        networks = {
          ${netName} = {
            requiredForOnline = "no";
            activationPolicy = "up";
            address = [
              "${prefix}.1/32"
            ];
            nftables = {
              allowInputConnected = true;
              tunInterfaces = [
                "wlp170s0"
              ];
            };
            routes = [
              {
                Destination = "${cidr}";
              }
            ];
            networkConfig = {
              IPv4Forwarding = true;
            };
          };
        };
      };
    };
  };

  networking = {
    nat = {
      enable = true;
      internalIPs = [
        "${cidr}"
      ];
    };
  };
}
