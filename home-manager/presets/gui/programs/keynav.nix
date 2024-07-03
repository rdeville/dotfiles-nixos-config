{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      keynav
    ];
  };

  services = {
    keynav = {
      enable = true;
    };
  };
}
