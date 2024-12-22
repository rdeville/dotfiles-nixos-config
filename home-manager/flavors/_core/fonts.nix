{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      carlito
      vegur
      source-code-pro
      jetbrains-mono
      noto-fonts-color-emoji
      # Icons
      font-awesome
      # Nerdfont Icons
      nerd-fonts.fira-code
    ];
  };
  fonts = {
    fontconfig = {
      enable = true;
      defaultFonts = {
        emoji = [
          "noto-fonts-color-emoji"
          "font-awesome"
        ];
        monospace = ["FiraCode"];
        sansSerif = ["FiraCode"];
        serif = ["FiraCode"];
      };
    };
  };
}
