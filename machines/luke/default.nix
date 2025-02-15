{
  inputs,
  lib,
  pkgs,
  ...
}: let
  base = import ./base.nix;
in {
  imports = [
    inputs.disko.nixosModules.disko
    ./os.nix
    ./disko.nix
  ];

  facter = {
    reportPath = ./facter.json;
  };

  # Use the systemd-boot EFI boot loader.
  boot = {
    loader = {
      systemd-boot = {
        enable = true;
      };

      efi = lib.mkDefault {
        canTouchEfiVariables = true;
      };
    };
  };

  hardware = {
    graphics = {
      enable = true;
    };
  };

  networking = {
    useDHCP = true;
  };

  nixpkgs = {
    hostPlatform = base.system;
  };

  programs = {
    dconf = {
      enable = true;
    };
  };

  systemd = {
    services = {
      sshd = {
        wantedBy = pkgs.lib.mkForce ["multi-user.target"];
      };
    };
  };
}
