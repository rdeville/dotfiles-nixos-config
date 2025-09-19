{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./_users
  ];

  boot = {
    tmp = {
      # Clean /tmp on boot
      cleanOnBoot = true;
    };

    loader = {
      systemd-boot = {
        enable = false;
      };

      efi = {
        canTouchEfiVariables = true;
      };

      grub = {
        enable = true;
        device = "nodev";
        useOSProber = true;
        efiSupport = true;
        # efiInstallAsRemovable = true;
      };
    };
  };

  facter = {
    reportPath = ../${config.os.hostName}/facter.json;
  };

  documentation = {
    nixos = {
      includeAllModules = lib.mkForce false;
    };
  };

  sops = {
    secrets = {
      "keys/rsa" = {
        format = "binary";
        sopsFile = ../${config.os.hostName}/_keys/${config.os.hostName}-rsa.enc.asc;
        key = "";
      };
      "keys/ed25519" = {
        format = "binary";
        sopsFile = ../${config.os.hostName}/_keys/${config.os.hostName}-ed25519.enc.asc;
        key = "";
      };
    };
    age = {
      keyFile = "/etc/age/key.txt";
    };
    defaultSopsFile = ../${config.os.hostName}/secrets.enc.yaml;
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
      openssl # openssh key generator
      dive # container explorator
      wget # download utility
    ];
    etc = {
      "ssh/ssh_host_rsa_key" = {
        source = config.sops.secrets."keys/rsa".path;
      };
      "ssh/ssh_host_rsa_key.pub" = {
        source = ../${config.os.hostName}/_keys/${config.os.hostName}-rsa.pub;
      };
      "ssh/ssh_host_ed25519_key" = {
        source = config.sops.secrets."keys/ed25519".path;
      };
      "ssh/ssh_host_ed25519_key.pub" = {
        source = ../${config.os.hostName}/_keys/${config.os.hostName}-ed25519.pub;
      };
    };
  };

  networking = {
    enableIPv6 = false;
  };

  nix = {
    settings = {
      trusted-users = [
        "@deploy"
      ];
    };
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  programs = {
    dconf = {
      enable = true;
    };
  };

  security = {
    sudo = {
      extraRules = [
        {
          # From https://github.com/cole-h/nixos-config/blob/f31f40f8d97800ee2438be8ebe47aa5bb7ecff03/modules/config/deploy.nix
          groups = [
            "deploy"
          ];
          runAs = "root";
          commands = let
            options = ["NOPASSWD"];
            storePath = "/nix/store/*";
            currSysPath = "/run/current-system/sw/bin";
            commands = [
              "${storePath}/bin/switch-to-configuration"
              "${storePath}/bin/env"
              # When using --sudo
              "${currSysPath}/nix-store"
              "${currSysPath}/nix-env"
              # When using --use-remote-sudo
              "${currSysPath}/systemd-run"
            ];
          in
            builtins.map (command: {
              inherit
                options
                command
                ;
            })
            commands;
        }
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

  os = {
    flavors = {
      ssh-server = {
        enable = true;
      };
    };
  };
}
