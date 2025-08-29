{pkgs, ...}: {
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
  };

  virtualisation = {
    libvirtd = {
      enable = true;
    };
  };

  os = {
    isMain = true;
    users = {
      users = {
        rdeville = {
          extraGroups = [
            "docker"
            "libvirtd"
            "qemu-libvirtd"
          ];
        };
      };
    };

    flavors = {
      docker = {
        enable = true;
        rootless = false;
      };
    };
  };
}
