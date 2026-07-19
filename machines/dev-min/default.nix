{
  lib,
  modulesPath,
  ...
}: let
  base = import ./base.nix;
in {
  options.topology.id = lib.mkOption {
    defaultText = lib.literalMD "Value of `networking.hostName`";
  };

  imports = [
    (modulesPath + "/installer/cd-dvd/installation-cd-minimal.nix")
    ./virtualisation.nix
    ./hardware-configuration.nix
    ./os.nix
  ];

  config = {
    networking = {
      inherit (base) hostName;
      useDHCP = lib.mkDefault true;
    };

    topology = {
      id = base.hostName;
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
        enable = false;
      };
    };
  };
}
