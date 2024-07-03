{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      hollywood
      discord
      whatsapp-for-linux
      signal-desktop
    ];
  };
}
