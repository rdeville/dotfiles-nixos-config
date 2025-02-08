{
  config,
  pkgs,
  lib,
  ...
}: let
  name = builtins.baseNameOf ./.;
  subname = "gtk";
  cfg = config.hm.flavors.${name}.${subname};
in {
  options = {
    hm = {
      flavors = {
        ${name} = {
          ${subname} = {
            enable =
              lib.mkDependEnabledOption ''
                Install ${name}.${subname} Home-Manager flavor.
              ''
              config.hm.flavors.${name}.enable;
          };
        };
      };
    };
  };

  config = lib.mkIf (cfg.enable && (! config.hm.isDarwin)) {
    gtk = {
      enable = ! config.hm.isDarwin;
      cursorTheme = {
        name = "Vimix-cursors";
        package = with pkgs; vimix-cursors;
        size = 0;
      };
      font = {
        name = config.hm.flavors.${name}.font.name;
        package = config.hm.flavors.${name}.font.pkgs;
        size = 10;
      };
      theme = {
        name = "Qogir-Manjaro-Dark";
        package = pkgs.qogir-theme.override {
          themeVariants = ["manjaro"];
          colorVariants = ["dark"];
          tweaks = ["square"];
        };
      };
      # iconTheme = {
      #   name = "Qogir-manjaro";
      #   package = pkgs.qogir-icon-theme.override {
      #     themeVariants = ["manjaro"];
      #     colorVariants = ["dark"];
      #   };
      # };
      gtk2 = {
        configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
      };
    };
  };
}
