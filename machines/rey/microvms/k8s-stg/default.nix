{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: let
  mac = "02:00:00:00:00:01";
  parentName = config.os.hostName;
  vmName = "vm-k8s-rey";
  isProd = config.os.isProd;

  users = {
    rdeville = {
      isSudo = true;
      openssh = {
        authorizedKeys = {
          keyFiles = [
            ../../../darth-maul/users/rdeville/_keys/rdeville-darth-maul.pub
            ../../../rey/users/rdeville/_keys/rdeville-rey.pub
          ];
        };
      };
    };
    root = {};
  };

  secrets =
    builtins.foldl' (acc: elem:
      {
        "users/${elem}/password" = {
          neededForUsers = true;
        };
      }
      // acc) {} (
      builtins.filter (user: (
        # Ignore users azathoth and cthulhu, no password login
        (builtins.match "test" user != [])
        && (builtins.match "azathoth" user != [])
        && (builtins.match "cthulhu" user != [])
      )) (builtins.attrNames users)
    )
    // {
      "keys/rsa" = {
        format = "binary";
        sopsFile = ../../../${config.os.hostName}/_keys/${config.os.hostName}-rsa.enc.asc;
        key = "";
      };
      "keys/ed25519" = {
        format = "binary";
        sopsFile = ../../../${config.os.hostName}/_keys/${config.os.hostName}-ed25519.enc.asc;
        key = "";
      };
    };
in {
  systemd = {
    network = {
      networks = {
        "90-${vmName}" = {
          matchConfig = {
            Name = "${vmName}";
          };
          address = [
            "172.20.0.1/32"
          ];
          routes = [
            {
              Destination = "172.20.0.0/24";
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
    firewall = {
      interfaces = {
        "${vmName}" = {
          allowedTCPPorts = [
            # Kube API
            6443
          ];
        };
      };
    };
  };



  microvm = {
    vms = {
      ${vmName} = {
        specialArgs = {
          inherit inputs lib;
        };

        config = {config, ...}: {
          imports =
            [
              inputs.sops-nix.nixosModules.sops
            ]
            ++ (
              if isProd
              then [
                inputs.nixos-stable.nixosModules.os
              ]
              else [
                inputs.nixos.nixosModules.os
              ]
            );

          os = {
            inherit isProd;
            hostName = "${vmName}";

            users = {
              inherit users;
            };

            flavors = {
              ssh-server = {
                enable = true;
                openFirewall = true;
              };

              k3s = {
                enable = true;
                role = "server";
                disableAgent = false;
                clusterInit = true;
                extraFlags = [
                  "--default-local-storage-path /var/lib/k8s-data"
                  "--tls-san kube.rey.tekunix.cloud"
                ];
              };
            };
          };

          microvm = {
            vcpu = 2;
            mem = 8192;
            interfaces = [
              {
                type = "tap";
                id = "${vmName}";
                inherit mac;
              }
            ];
            volumes = [
              {
                image = "/var/lib/microvms/${vmName}/volumes/var-lib-rancher-k3s.img";
                label = "librancher";
                mountPoint = "/var/lib/rancher/k3s";
                size = 25600;
              }
              {
                image = "/var/lib/microvms/${vmName}/volumes/etc-rancher-k3s.img";
                label = "etcrancher";
                mountPoint = "/etc/rancher/k3s";
                size = 256;
              }
            ];
            shares = [
              {
                source = "/nix/store";
                mountPoint = "/nix/.ro-store";
                tag = "nix-store-ro";
                proto = "virtiofs";
              }
              {
                source = "/etc/age";
                mountPoint = "/etc/age";
                tag = "etc-age-ro";
                proto = "virtiofs";
              }
              {
                source = "/var/lib/microvms/${vmName}/var/log";
                mountPoint = "/var/log";
                tag = "var-log";
                proto = "virtiofs";
              }
            ];
          };

          sops = {
            inherit secrets;
            age = {
              keyFile = "/etc/age/key.txt";
            };
            defaultSopsFile = ../../../${parentName}/secrets.enc.yaml;
          };

          environment = {
            etc = {
              "machine-id" = {
                mode = "0644";
                text = vmName;
              };
              "ssh/ssh_host_rsa_key" = {
                source = config.sops.secrets."keys/rsa".path;
              };
              "ssh/ssh_host_rsa_key.pub" = {
                source = ../../../${parentName}/_keys/${parentName}-rsa.pub;
              };
              "ssh/ssh_host_ed25519_key" = {
                source = config.sops.secrets."keys/ed25519".path;
              };
              "ssh/ssh_host_ed25519_key.pub" = {
                source = ../../../${parentName}/_keys/${parentName}-ed25519.pub;
              };
            };
          };

          systemd = {
            network = {
              enable = true;

              networks = {
                "10-eth" = {
                  matchConfig = {
                    MACAddress = mac;
                  };
                  # Static IP configuration
                  address = [
                    "172.20.0.2/32"
                  ];
                  routes = [
                    {
                      # A route to the host
                      Destination = "172.20.0.0/32";
                      GatewayOnLink = true;
                    }
                    {
                      # Default route
                      Destination = "0.0.0.0/0";
                      Gateway = "172.20.0.1";
                      GatewayOnLink = true;
                    }
                  ];
                  networkConfig = {
                    # DNS servers no longer come from DHCP nor Router
                    # Advertisements. Perhaps you want to change the defaults:
                    DNS = [
                      "89.234.140.170"
                    ];
                  };
                };
              };
            };
          };

          environment = {
            systemPackages = with pkgs; [
              ethtool # manage NIC settings (offload, NIC feeatures, ...)
              tcpdump # view network traffic
              conntrack-tools # view network connection states
              traceroute # view network routes
              iw # view wlan interfaces and devices
              dig # DNS lookup utiliy
              cilium-cli # Cilium utils
            ];
          };

          networking = {
            enableIPv6 = false;
            firewall = {
              enable = lib.mkForce false;
              allowPing = true;
              allowedUDPPorts = [
                # Cilium Port
                # See: https://docs.cilium.io/en/stable/operations/system_requirements/
                # Wireguard
                51871
              ];
              allowedTCPPorts = [
                # Kube API
                6443
                # Cilium Port
                # See: https://docs.cilium.io/en/stable/operations/system_requirements/
                # Cilium health
                4240
                # Cilium metrics
                10250
                # Hubble metrics
                9965
                # Hubble peer
                4244
              ];
              # See: https://github.com/cilium/cilium/issues/27900#issuecomment-2572253315
              trustedInterfaces = [
                "cilium_net*"
                "cilium_host*"
                "cilium_vxlan"
                "lxc*"
              ];
            };

            nftables = {
              enable = lib.mkForce false;
              ruleset = builtins.readFile ./config.nftables;
            };
          };

          fileSystems = {
            "/etc/age" = {
              neededForBoot = lib.mkForce true;
            };
          };
        };
      };
    };
  };
}
