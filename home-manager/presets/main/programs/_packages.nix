{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      alejandra
      discord
      signal-desktop
      whatsapp-for-linux
    ];
  };
}
