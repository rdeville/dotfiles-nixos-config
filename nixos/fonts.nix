{pkgs, ...}: {
  # Fonts
  fonts.packages = with pkgs; [
    # NixOS
    carlito
    vegur
    source-code-pro
    jetbrains-mono
    # Icons
    font-awesome
    # Nerdfont Icons
    nerd-fonts.fira-code
  ];
}
