{
  config,
  pkgs,
  ...
}: {
  gtk = {
    enable = ! config.hm.isDarwin;
    cursorTheme = {
      name = "Vimix-cursors";
      package = with pkgs; vimix-cursors;
      size = 0;
    };
    font = {
      name = "FiraCode";
      package = with pkgs; nerd-fonts.fira-code;
      size = 10;
    };
    theme = {
      name = "Qogir-Manjaro-Dark";
      package = with pkgs; qogir-theme;
    };
    iconTheme = {
      name = "Qogir-manjaro";
      package = with pkgs; qogir-icon-theme;
    };
    gtk2 = {
      configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
    };
  };
}
