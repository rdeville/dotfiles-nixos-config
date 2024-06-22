# Specific system configuration settings for vm
{
  cfg,
  lib,
  ...
}: {
  nixos-shell = {
    mounts = {
      mountHome = false;
      mountNixProfile = false;
    };
  };

  virtualisation = {
    cores = cfg.vms.cpus;
    memorySize = cfg.vms.ram * 1024;
    diskSize = cfg.vms.disk * 1024;
    graphics = cfg.vms.graphics;
    # writableStore = false;
    # mountHostNixStore = false;
    # writableStoreUseTmpfs = false;
    libvirtd = {
      enable = true;
    };
    sharedDirectories = {
      # nixos = {
      #   source = "${builtins.getEnv "PWD"}/../../";
      #   target = "/home/nixos";
      # };
    };
    diskImage = "../${cfg.hostname}.qcow2";
    fileSystems = {
      "/" = {
        device = lib.mkForce "none";
        fsType = lib.mkForce "tmpfs";
        options = [
          "defaults"
          "size=2G"
          "mode=755"
        ];
      };
      "/nix" = {
        device = "/dev/vda";
        fsType = lib.mkForce "ext4";
        label = "nixos";
        options = lib.mkForce ["defaults"];
        mountPoint = "/nix";
      };
    };
  };

  programs = {
    virt-manager = {
      enable = true;
    };
  };
}
