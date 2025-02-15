{
  lib,
  pkgs,
  ...
}: let
  base = import ./base.nix;
in {
  imports = [
    # (modulesPath + "/installer/cd-dvd/installation-cd-minimal.nix")
    ./hardware-configuration.nix
    ./os.nix
  ];

  facter = {
    reportPath = ./facter.json;
  };

  # Use the systemd-boot EFI boot loader.
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      systemd-boot = {
        enable = true;
      };

      efi = lib.mkDefault {
        canTouchEfiVariables = true;
      };

      # grub = {
      #   enable = lib.mkForce true;
      #   device = "nodev";
      #   useOSProber = true;
      #   efiSupport = true;
      # };
    };
  };

  hardware = {
    graphics = {
      enable = true;
    };

    nvidia = {
      powerManagement = {
        enable = true;
        finegrained = false;
      };
      open = false;
      nvidiaSettings = true;
      package = pkgs.linuxPackages_latest.nvidiaPackages.latest;
    };
  };

  networking = {
    useDHCP = true;
  };

  nixpkgs = {
    hostPlatform = base.system;
    config = {
      allowUnfreePredicate = pkg:
        builtins.elem (lib.getName pkg) [
          "discord"
          "nvidia-settings"
          "nvidia-x11"
          "steam"
          "steam-unwrapped"
          "terraform"
        ];
    };
  };

  programs = {
    dconf = {
      enable = true;
    };

    ydotool = {
      enable = true;
      group = "ydotool";
    };
  };

  services = {
    xserver = {
      videoDrivers = ["nvidia"];
    };
  };

  virtualisation = {
    libvirtd = {
      enable = true;
    };
  };
}
