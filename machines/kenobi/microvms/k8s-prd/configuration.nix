{
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
  sops = {
    secrets =
      secrets
      // {
        "k8s-prd-token" = {
          sopsFile = ../../../../common/secrets/k8s-prd.enc.yaml;
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
        openFirewall = true;
      };

      k3s = {
        enable = true;
        role = "server";
        disableAgent = false;
        clusterInit = true;
        extraFlags = [
          "--default-local-storage-path /var/lib/k8s-data"
          "--tls-san kube.tekunix.cloud"
          "--tls-san 172.30.128.201"
        ];
        tokenFile = config.sops.secrets."k8s-prd-token".path;
      };
    };
  };

  microvm = {
    vcpu = 1;
    mem = 4096;
    volumes = [
      {
        image = "/var/lib/microvms/${vmName}/volumes/var-lib-rancher-k3s.img";
        label = "var-rancher-k3s";
        mountPoint = "/var/lib/rancher/k3s";
        size = 25600;
      }
      {
        image = "/var/lib/microvms/${vmName}/volumes/etc-rancher-k3s.img";
        label = "etc-rancher-k3s";
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

  environment = {
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

  environment = {
    systemPackages = with pkgs; [
      ethtool # manage NIC settings (offload, NIC feeatures, ...)
      tcpdump # view network traffic
      conntrack-tools # view network connection states
      wireguard-tools # Wireguard binaries
      traceroute # view network routes
      iw # view wlan interfaces and devices
      dig # DNS lookup utiliy
      cilium-cli # Cilium utils
    ];
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

  fileSystems = {
    "/etc/age" = {
      neededForBoot = lib.mkForce true;
    };
  };
}
