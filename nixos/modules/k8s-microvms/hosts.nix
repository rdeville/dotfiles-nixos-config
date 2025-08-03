{
  self,
  inputs,
  config,
  lib,
  ...
}: let
  cfg = config.k8s-microvms;
  enabledVMs =
    builtins.filter (
      elem:
        cfg.${elem}.enable
    )
    (builtins.attrNames cfg);
  isProd = config.os.isProd;
  imports =
    if isProd
    then [
      inputs.nixos-stable.nixosModules.os
    ]
    else [
      inputs.nixos.nixosModules.os
    ];
in {
  config = lib.mkIf (cfg != {}) {
    systemd = {
      tmpfiles = {
        rules = builtins.foldl' (acc: elem: let
          parentName = config.os.hostName;
          vmName = "vm-${parentName}-${elem}";
        in
          [
            # Create folder needed for VM volumes
            "d /var/lib/microvms/${vmName}/var 0755 microvm kvm -"
            "d /var/lib/microvms/${vmName}/volumes 0755 microvm kvm -"
            "d /var/lib/microvms/${vmName}/var/log 0755 microvm systemd-journal -"
            # Creates a symlink of each MicroVM's journal under the host's /var/log/journal
            "L+ /var/log/journal/${vmName} - - - - /var/lib/microvms/${vmName}/var/log/journal"
          ]
          ++ acc) []
        enabledVMs;
      };
    };

    os = {
      flavors = {
        network = {
          networks = builtins.foldl' (acc: elem: let
            vmCfg = cfg.${elem};
            netName = "vm-${elem}";
            prefix = "172.20.${vmCfg.envID}";
            length = "24";
            cidr = "${prefix}.0/${length}";
          in
            {
              ${netName} = {
                interface = netName;
                requiredForOnline = "no";
                activationPolicy = "up";
                address = [
                  "${prefix}.1/32"
                ];
                routes = [
                  {
                    Destination = cidr;
                  }
                ];
                nftables = {
                  # Required for DNS request
                  allowInput = true;
                  forward = {
                    outputInterfaces = [
                      "eno*"
                      "enp*"
                      "wg-tun-illyse"
                    ];
                  };
                };
                networkConfig = {
                  IPv4Forwarding = true;
                };
              };
            }
            // acc) {}
          enabledVMs;
        };
      };
    };

    networking = {
      nat = {
        enable = true;
        internalIPs = builtins.foldl' (acc: elem: let
          prefix = "172.20.${cfg.${elem}.envID}";
          length = "24";
          cidr = "${prefix}.0/${length}";
        in
          [
            cidr
          ]
          ++ acc) []
        enabledVMs;
      };
    };

    microvm = {
      vms = builtins.foldl' (acc: elem: let
        vmCfg = cfg.${elem};
        parentName = config.os.hostName;
        vmName = "vm-${parentName}-${elem}";
      in
        {
          ${vmName} = {
            specialArgs = {
              inherit inputs lib self vmCfg;
            };

            config = {config, ...}: {
              imports =
                [
                  inputs.sops-nix.nixosModules.sops
                  inputs.nix-topology.nixosModules.default
                  inputs.home-manager.nixosModules.home-manager
                  ./configuration.nix
                ]
                ++ imports;

              os = {
                inherit isProd parentName;
                hostName = vmName;
              };
            };
          };
        }
        // acc) {}
      enabledVMs;
    };
  };
}
