{
  self,
  inputs,
  config,
  lib,
  vmCfg,
  pkgs,
  ...
}: let
  parentName = config.os.parentName;
  vmName = "vm-${parentName}-k8s-${vmCfg.env}";

  vm = {
    interface = "enp0s8";
    network = "vm-k8s-${vmCfg.env}";
    prefix = "172.20.${vmCfg.envID}";
    mac = "02:00:00:00:00:a0";
  };

  isProd = config.os.isProd;
  imports =
    if isProd
    then [
      # Internal Modules
      inputs.nixos-stable.homeManagerModules.hm
    ]
    else [
      # Internal Modules
      inputs.nixos.homeManagerModules.hm
    ];
in {
  imports = [
    ../k8s-server
  ];

  config = {
    k8s-server = {
      enable = true;
      inherit
        (vmCfg)
        id
        role
        env
        hostKeyDir
        clusterInit
        disableAgent
        clusterDomain
        clusterAddress
        network
        ;
      wireguard = {
        inherit (vmCfg.wireguard) endpoint;
        outputInterfaces = [
          vm.interface
        ];
      };
    };

    sops = {
      inherit (vmCfg) defaultSopsFile;
      secrets = {
        "keys/rsa" = {
          format = "binary";
          sopsFile = vmCfg.hostKeyDir + "/${config.os.hostName}-rsa.enc.asc";
          key = "";
        };
        "keys/ed25519" = {
          format = "binary";
          sopsFile = vmCfg.hostKeyDir + "/${config.os.hostName}-ed25519.enc.asc";
          key = "";
        };
      };
      age = {
        keyFile = "/etc/age/key.txt";
      };
    };

    microvm = {
      inherit (vmCfg) vcpu mem;
      writableStoreOverlay = "/nix/.rw-store";
      interfaces = [
        {
          inherit (vm) mac;
          type = "tap";
          id = vm.network;
        }
      ];
      volumes = [
        {
          image = "/var/lib/microvms/${vmName}/volumes/var-lib-rancher.img";
          label = "var-rancher";
          mountPoint = "/var/lib/rancher";
          size = 25600;
        }
        {
          image = "/var/lib/microvms/${vmName}/volumes/etc-rancher.img";
          label = "etc-rancher";
          mountPoint = "/etc/rancher";
          size = 256;
        }
        {
          image = "/var/lib/microvms/${vmName}/volumes/nix-store-overlay.img";
          label = "store-overlay";
          mountPoint = config.microvm.writableStoreOverlay;
          size = 2048;
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

    os = {
      flavors = {
        network = {
          enable = true;
          networks = {
            ${vm.network} = {
              interface = vm.interface;
              matchConfig = {
                name = "enx*";
              };
              activationPolicy = "up";
              nftables = {
                allowInputConnected = true;
                forward = {
                  inputInterfaces = [
                    # Allow container to leave the VM
                    "lxc*"
                  ];
                  outputInterfaces = [
                    # Allow response from internet to cluster
                    "cilium_host*"
                  ];
                };
              };
              address = [
                "${vm.prefix}.${toString vmCfg.id}/32"
              ];
              dns = [
                "${vm.prefix}.1"
              ];
              routes = [
                {
                  # A route to the host
                  Destination = "${vm.prefix}.0/32";
                  GatewayOnLink = true;
                }
                {
                  # Default route
                  Destination = "0.0.0.0/0";
                  Gateway = "${vm.prefix}.1";
                  GatewayOnLink = true;
                }
              ];
              topology = {
                addresses = [
                  "${vm.prefix}.${toString vmCfg.id}"
                ];
              };
            };
          };
        };
      };
    };

    nix = {
      settings = {
        auto-optimise-store = false;
      };
    };

    environment = {
      etc = {
        machine-id = {
          mode = "0644";
          text = vmName;
        };
      };
      systemPackages = with pkgs; [
        ethtool # manage NIC settings (offload, NIC feeatures, ...)
        tcpdump # view network traffic
        conntrack-tools # view network connection states
        wireguard-tools # Wireguard binaries
        traceroute # view network routes
        arp-scan # scan arp packet
        iw # view wlan interfaces and devices
        dig # DNS lookup utiliy
        cilium-cli # Cilium utils
        arp-scan # ARP packet scanner
        neovim # terminal editor
        nettools # Network utility (like netstat)
      ];

      etc = {
        "ssh/ssh_host_rsa_key" = {
          source = config.sops.secrets."keys/rsa".path;
        };
        "ssh/ssh_host_rsa_key.pub" = {
          source = vmCfg.hostKeyDir + "/${config.os.hostName}-rsa.pub";
        };
        "ssh/ssh_host_ed25519_key" = {
          source = config.sops.secrets."keys/ed25519".path;
        };
        "ssh/ssh_host_ed25519_key.pub" = {
          source = vmCfg.hostKeyDir + "/${config.os.hostName}-ed25519.pub";
        };
      };
    };

    home-manager = {
      useGlobalPkgs = false;
      useUserPackages = true;
      extraSpecialArgs = {
        # Here the magic happens with inputs into home-manager
        inherit inputs lib self;
      };
      users = builtins.foldl' (acc: user:
        {
          # Here is the magic to manage both HM/Nixos in a clean homogeneous way
          "${user}" = {
            imports =
              [
                ./home-manager.nix
              ]
              ++ imports;

            home = {
              stateVersion = config.system.stateVersion;
              username = user;
            };
          };
        }
        // acc) {} (builtins.attrNames config.os.users.users);
    };

    fileSystems = {
      "/etc/age" = {
        neededForBoot = lib.mkForce true;
      };
    };
  };
}
