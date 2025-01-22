{
  config,
  pkgs,
  ...
}: let
  name = builtins.baseNameOf ./.;
  cfg = config.hm.flavors.${name};
in {
  gtk = {
    enable = ! config.hm.isDarwin;
    cursorTheme = {
      name = "Vimix-cursors";
      package = with pkgs; vimix-cursors;
      size = 0;
    };
    font = {
      name = cfg.font.name;
      package = cfg.font.pkgs;
      size = 10;
    };
    theme = {
      name = "Qogir-Manjaro-Dark";
      package = (pkgs.qogir-theme.override {
        themeVariants = ["manjaro"];
        colorVariants = ["dark"];
        tweaks = ["square"];
      });
    };
    iconTheme = {
      name = "Qogir-manjaro";
      package = (pkgs.qogir-icon-theme.override {
        themeVariants = ["manjaro"];
        colorVariants = ["dark"];
      });
    };
    gtk2 = {
      configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
    };
  };
}
