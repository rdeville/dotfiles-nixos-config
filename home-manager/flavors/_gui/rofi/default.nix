{
  inputs,
  config,
  pkgs,
  lib,
  ...
}: let
  name = builtins.baseNameOf ../.;
  subname = builtins.baseNameOf ./.;
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
              (config.hm.flavors.${name}.enable && ! config.hm.isDarwin);
          };
        };
      };
    };
  };

  config = lib.mkIf cfg.enable {
    home = {
      packages = with pkgs; [
        rofi-power-menu
        # Required for my rofi menus
        wl-clipboard-rs
        # Fonts required by inputs.rofi-theme
        icomoon-feather
        nerd-fonts.iosevka
        nerd-fonts.jetbrains-mono
      ];
    };

    xdg = {
      # dataFile = {
      #   "rofi/themes" = {
      #     source = "${inputs.rofi-themes}/files";
      #   };
      # };
      configFile = {
        "rofi/scripts" = {
          source = ./assets/scripts;
        };
      };
    };

    programs = {
      rofi = {
        inherit
          (cfg)
          enable
          ;
        terminal = "kitty";
      };
    };
  };
}
