{
  lib,
  modulesPath,
  pkgs,
  ...
}: let
  base = import ./base.nix;

  users = {
    nixos = {
      isSudo = true;
      password = "nixos";
      openssh = {
        authorizedKeys = {
          keyFiles = [
            ../../pubkeys/nixos-bootable-usb.pub
          ];
        };
      };
    };
    root = {
      password = "root";
    };
  };
in {
  imports = [
    (modulesPath + "/installer/cd-dvd/installation-cd-minimal.nix")
  ];

  networking = {
    useDHCP = lib.mkDefault true;
  };

  nixpkgs = {
    hostPlatform = base.system;
  };

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
  };

  isoImage = {
    squashfsCompression = "gzip -Xcompression-level 1";
  };

  # Enable SSH in the boot process.
  systemd = {
    services = {
      sshd = {
        wantedBy = pkgs.lib.mkForce ["multi-user.target"];
      };
    };
  };

  hardware = {
    graphics = {
      enable = base.isGui;
    };
  };

  os = {
    inherit (base) hostName isGui isMain system;
    users = {
      inherit users;
    };

    flavors = {
      _core = {
        nix-ld = {
          enable = true;
        };
      };
      display-manager = {
        enable = base.isGui;
        ly = {
          enable = true;
        };
      };
      window-manager = {
        enable = base.isGui;
        awesome = {
          enable = true;
        };
      };
      ssh-server = {
        enable = true;
      };
    };
  };
}
