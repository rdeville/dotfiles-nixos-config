{
  self,
  inputs,
  config,
  lib,
  pkgs,
  ...
}: let
  parentName = config.os.parentName;
  vmName = "vm-${parentName}-${builtins.baseNameOf ./.}";

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
    cthulhu = {
      isSudo = true;
      openssh = {
        authorizedKeys = {
          keyFiles = [
            ../../../darth-maul/users/cthulhu/_keys/cthulhu-darth-maul.pub
            ../../../rey/users/cthulhu/_keys/cthulhu-rey.pub
            ../../../kenobi/users/cthulhu/_keys/cthulhu-kenobi.pub
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
        sopsFile = ./_keys/${config.os.hostName}-rsa.enc.asc;
        key = "";
      };
      "keys/ed25519" = {
        format = "binary";
        sopsFile = ./_keys/${config.os.hostName}-ed25519.enc.asc;
        key = "";
      };
    };
in {
  imports = [
    ../../../_templates/k3s.nix
  ];

  sops = {
    secrets =
      secrets
      // {
        "k8s-dev-token" = {
          sopsFile = ../../../../common/secrets/k8s-dev.enc.yaml;
        };
      };
    age = {
      keyFile = "/etc/age/key.txt";
    };
    defaultSopsFile = ./secrets.enc.yaml;
  };

  os = {
    users = {
      inherit users;
    };

    flavors = {
      ssh-server = {
        enable = true;
      };

      k3s = {
        role = "server";
        disableAgent = false;
        clusterInit = true;
        extraFlags = [
          "--tls-san kube.dev.tekunix.internal"
          "--tls-san 172.30.160.201"
          "--node-ip 172.30.160.201"
          "--node-external-ip 172.30.160.201"
        ];
        tokenFile = config.sops.secrets."k8s-dev-token".path;
      };
    };
  };

  microvm = {
    vcpu = 1;
    mem = 4096;
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

  nix = {
    settings = {
      auto-optimise-store = false;
    };
  };

  environment = {
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
      machine-id = {
        mode = "0644";
        text = vmName;
      };
      "ssh/ssh_host_rsa_key" = {
        source = config.sops.secrets."keys/rsa".path;
      };
      "ssh/ssh_host_rsa_key.pub" = {
        source = ./_keys/${config.os.hostName}-rsa.pub;
      };
      "ssh/ssh_host_ed25519_key" = {
        source = config.sops.secrets."keys/ed25519".path;
      };
      "ssh/ssh_host_ed25519_key.pub" = {
        source = ./_keys/${config.os.hostName}-ed25519.pub;
      };
    };
  };

  security = {
    sudo = {
      extraRules = [
        {
          users = [
            "cthulhu"
          ];
          commands = [
            {
              command = "ALL";
              options = ["SETENV" "NOPASSWD"];
            }
          ];
        }
      ];
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
          home = {
            stateVersion = config.system.stateVersion;
            username = user;
            sessionVariables = {
              HOST = config.os.hostName;
              EDITOR = "nvim";
            };
            preferXdgDirectories = true;
          };

          systemd = {
            user = {
              startServices = "sd-switch";
            };
          };

          programs = {
            home-manager = {
              enable = true;
            };

            zsh = {
              enable = true;
              autosuggestion.enable = true;
              syntaxHighlighting = {
                enable = true;
                highlighters = [
                  "main"
                ];
              };

              defaultKeymap = "viins";
              profileExtra = ''
                export LC_ALL="en_US.UTF-8"
              '';

              shellAliases = {
                l = "ls";
                ll = "ls -l";
                la = "ls -a";
                lla = "ls -al";
                # grep overload
                grep = "grep --color=auto";
              };
            };
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
}
