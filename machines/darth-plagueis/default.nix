{
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
}
