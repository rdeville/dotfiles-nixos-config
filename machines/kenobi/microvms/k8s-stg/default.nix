{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: let
  mac = "02:00:00:00:00:01";
  parentName = config.os.hostName;
  vmName = "vm-k8s-stg";
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
            "172.16.144.1/32"
          ];
          routes = [
            {
              Destination = "172.16.144.0/24";
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
            # DNS
            53
            # Kube API
            6443
          ];
          allowedUDPPorts = [
            # DNS
            53
          ];
        };
      };
    };

    nftables = {
      ruleset = builtins.readFile ./config.nftables;
    };
  };

  services = {
    nginx = {
      enable = true;
      streamConfig = ''
        log_format basic '$remote_addr - - [$time_local] $protocol $status $bytes_sent $bytes_received $session_time "$upstream_addr"';

        access_log /var/log/nginx/kube.stg.tekunix.cloud.access.log basic;
        error_log /var/log/nginx/kube.stg.tekunix.cloud.error.log debug;

        upstream k8s-stg-api {
          server 172.16.144.2:6443;
        }

        upstream k8s-stg-http {
          server 172.16.144.2:80;
        }

        upstream k8s-stg-https {
          server 172.16.144.2:443;
        }

        server {
          listen 172.16.144.1:6443;
          server_name kube.stg.tekunix.cloud;
          proxy_pass k8s-stg-api;
          proxy_bind 172.16.144.1;
        }

        server {
          listen 172.16.144.1:80;
          server_name *.stg.tekunix.cloud;
          proxy_pass k8s-stg-http;
        }

        server {
          listen 172.16.144.1:443;
          server_name *.stg.tekunix.cloud;
          proxy_pass k8s-stg-https;
        }
      '';

      virtualHosts = {
        "*.stg.tekunix.cloud" = {
          listen = [
            {
              addr = "89.234.140.170";
              port = 80;
            }
            {
              addr = "89.234.140.170";
              port = 443;
            }
          ];
          locations = {
            "/" = {
              proxyPass = "http://172.16.144.1";
              proxyWebsockets = true;
            };
          };
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
                  "--tls-san kube.stg.tekunix.cloud"
                ];
              };
            };
          };

          microvm = {
            vcpu = 2;
            mem = 4096;
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
                    "172.16.144.2/32"
                  ];
                  routes = [
                    {
                      # A route to the host
                      Destination = "172.16.144.0/32";
                      GatewayOnLink = true;
                    }
                    {
                      # Default route
                      Destination = "0.0.0.0/0";
                      Gateway = "172.16.144.1";
                      GatewayOnLink = true;
                    }
                  ];
                  networkConfig = {
                    # DNS servers no longer come from DHCP nor Router
                    # Advertisements. Perhaps you want to change the defaults:
                    DNS = [
                      "172.16.144.1"
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
