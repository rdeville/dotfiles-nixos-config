{config, ...}: {
  # Use the systemd-boot EFI boot loader.
  boot = {
    loader = {
      systemd-boot = {
        enable = true;
      };
      efi = {
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
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
  };
}
