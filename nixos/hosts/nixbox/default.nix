# Specific system configuration settings for vm
{
  inputs,
  pkgs,
  lib,
  cfg,
  ...
}: {
  imports = [./hardware-configuration.nix];

  system = {
    stateVersion = cfg.stateVersion;
  };

  # Boot Options
  boot = {
    loader = {
      grub = {
        enable = lib.mkForce true;
        device = "nodev";
      };
      timeout = 1;
    };
    tmp = {
      cleanOnBoot = true;
      tmpfsSize = "5GB";
    };
    kernelPackages = pkgs.linuxPackages_latest;
  };

  environment = {
    # System Wide Packages
    systemPackages = with pkgs; [
      # Test Package
      hello
    ];
  };

  # Nix Package Manager Settings
  nix = {
    settings = {
      auto-optimise-store = lib.mkForce false;
    };
  };

  # users = {
  #   users = {
  #     root = {
  #       password = "root";
  #     };
  #   };
  # };
}
