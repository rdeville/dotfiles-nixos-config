{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      keepassxc
      vimiv-qt
    ];
  };
}
