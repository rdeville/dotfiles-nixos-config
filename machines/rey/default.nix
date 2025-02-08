{
  config,
  lib,
  modulesPath,
  pkgs,
  ...
}: let
  base = import ./base.nix;
in {
  imports = [
    (modulesPath + "/installer/cd-dvd/installation-cd-minimal.nix")
    ./os.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot = {
    # kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      efi = lib.mkDefault {
        canTouchEfiVariables = true;
      };
      grub = {
        enable = lib.mkForce true;
        device = "nodev";
        useOSProber = true;
        efiSupport = true;
      };
    };
  };

  networking = {
    useDHCP = lib.mkDefault true;
  };

  nixpkgs = {
    hostPlatform = base.system;
    config = {
      allowUnfreePredicate = pkg:
        builtins.elem (lib.getName pkg) [
          "discord"
          "steam"
          "steam-unwrapped"
          "terraform"
        ];
    };
  };

  virtualisation = {
    libvirtd = {
      enable = true;
    };
  };

  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };

    graphics = {
      enable = base.isGui;
    };
  };
}
