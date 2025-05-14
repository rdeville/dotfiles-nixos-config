{pkgs, ...}: {
  hardware = {
    nvidia = {
      powerManagement = {
        enable = true;
        finegrained = false;
      };
      open = false;
      nvidiaSettings = true;
      package = pkgs.linuxPackages_latest.nvidiaPackages.latest;
    };
  };

  services = {
    xserver = {
      videoDrivers = [
        "nvidia"
      ];
    };
  };
}
