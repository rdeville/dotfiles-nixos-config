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
    ./virtualisation.nix
    ./hardware-configuration.nix
    ./os.nix
  ];

  networking = {
    useDHCP = lib.mkDefault true;
  };

  nixpkgs = {
    hostPlatform = base.system;
  };

  boot = {
    # Let us live dangerously with the latest kernel
    kernelPackages = pkgs.linuxPackages_latest;
  };

  # Enable SSH in the boot process
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
