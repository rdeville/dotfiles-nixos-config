{
  lib,
  config,
  cfg,
  ...
}: {
  boot = {
    initrd = {
      availableKernelModules = [
        "ata_piix"
        "uhci_hcd"
        "floppy"
        "sr_mod"
        "virtio_pci"
        "virtio_blk"
      ];
      kernelModules = [];
    };
    kernelModules = ["kvm-intel"];
    extraModulePackages = [];
  };

  # Root filesystem
  # fileSystems."/" = {
  #   device = "none";
  #   fsType = "tmpfs";
  #   options = [
  #     "defaults"
  #     "size=2G"
  #     "mode=755"
  #   ];
  # };
  fileSystems = {
    "/" = {
      device = "/dev/vda";
      fsType = "ext4";
    };
    "/nix/.rw-store" = {
      device = "/dev/vdb";
      fsType = "ext4";
    };
    "/nix" = {
      device = "/dev/vdc";
      fsType = "ext4";
    };
  };

  # Swap filesystem
  swapDevices = [];

  networking = {
    hostName = cfg.hostname;
    interfaces = {
      eth0 = {
        useDHCP = true;
      };
    };
  };

  hardware = {
    cpu = {
      intel = {
        updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
      };
    };
  };
}
