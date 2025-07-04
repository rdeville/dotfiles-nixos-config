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

    flavors = {
      docker = {
        enable = true;
        rootless = false;
      };
    };
  };
}
