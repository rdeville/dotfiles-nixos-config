{
  lib,
  modulesPath,
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
    config = {
      allowUnfree = true;
    };
  };

  boot = {
    # If we want to live dangerously with the latest kernel
    # kernelPackages = pkgs.linuxPackages_latest;
  };

  # Enable SSH in the boot process
  systemd = {
    services = {
      sshd = {
        wantedBy = [
          "multi-user.target"
        ];
      };
    };
  };

  hardware = {
    graphics = {
      enable = true;
    };
  };
}
