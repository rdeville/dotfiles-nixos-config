{
  config,
  lib,
  pkgs,
  ...
}: let
  vmName = "vm-${builtins.baseNameOf ./.}";

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

  secrets = {
    "keys/rsa" = {
      format = "binary";
      sopsFile = ../../../${config.os.parentName}/_keys/${config.os.parentName}-rsa.enc.asc;
      key = "";
    };
    "keys/ed25519" = {
      format = "binary";
      sopsFile = ../../../${config.os.parentName}/_keys/${config.os.parentName}-ed25519.enc.asc;
      key = "";
    };
  };
in {
  imports = [
    ./networks
  ];

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
          "--tls-san kube.rey.tekunix.cloud"
        ];
      };
    };
  };

  microvm = {
    vcpu = 2;
    mem = 8192;
    volumes = [
      {
        image = "/var/lib/microvms/${vmName}/volumes/var-lib-rancher-k3s.img";
        label = "var-lib-rancher-k3s";
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
        source = "/run/secrets/microvms/${vmName}/age";
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
    defaultSopsFile = ../../../${config.os.parentName}/secrets.enc.yaml;
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
        source = ../../../${config.os.parentName}/_keys/${config.os.parentName}-rsa.pub;
      };
      "ssh/ssh_host_ed25519_key" = {
        source = config.sops.secrets."keys/ed25519".path;
      };
      "ssh/ssh_host_ed25519_key.pub" = {
        source = ../../../${config.os.parentName}/_keys/${config.os.parentName}-ed25519.pub;
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

  fileSystems = {
    "/etc/age" = {
      neededForBoot = lib.mkForce true;
    };
  };
}
