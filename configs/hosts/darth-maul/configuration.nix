{
  config,
  pkgs,
  lib,
  os,
  ...
}: let
  steamUnfree =
    if os.flavors.steam.enable
    then [
      "steam"
      "steam-unwrapped"
    ]
    else [];
in {
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
      #   enable = true;
      #   device = "nodev";
      #   useOSProber = true;
      #   efiSupport = true;
      # };
    };
  };

  services = {
    xserver = {
      videoDrivers = ["nvidia"];
    };
  };

  nixpkgs = {
    config = {
      allowUnfreePredicate = pkg:
        builtins.elem (lib.getName pkg) (
          [
            "nvidia-x11"
            "nvidia-settings"
          ]
          ++ steamUnfree
        );
    };
  };

  virtualisation.libvirtd.enable = true;

  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
    graphics = {
      enable = true;
    };
    nvidia = {
      # modesettings.enable = true;
      powerManagement = {
        enable = false;
        finegrained = false;
      };
      open = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.latest;
    };
  };
}
