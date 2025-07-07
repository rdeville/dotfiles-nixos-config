{...}: let
  vmName = "vm-${builtins.baseNameOf ./.}";
  prefix = "172.20.0";
  length = "24";
  cidr = "${prefix}.0/${length}";
in {
  sops = {
    secrets = {
      "microvm/${vmName}/age/age.txt" = {
        format = "binary";
        sopsFile = ./_keys/age.enc.txt;
        key = "";
      };
    };
  };

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
        ${vmName} = {
          matchConfig = {
            Name = "${vmName}";
          };
          address = [
            "${prefix}.1/32"
          ];
          routes = [
            {
              Destination = "${cidr}";
            }
          ];
          networkConfig = {
            IPv4Forwarding = true;
            DHCPServer = false;
          };
          linkConfig = {
            RequiredForOnline = "no";
          };
        };
      };
    };
  };

  networking = {
    nat = {
      internalIPs = [
        "${cidr}"
      ];
    };
  };
}
