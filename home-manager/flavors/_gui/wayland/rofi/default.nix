{
  inputs,
  config,
  pkgs,
  lib,
  ...
}: let
  name = builtins.baseNameOf ../.;
  subname = builtins.baseNameOf ./.;
  subsubname = builtins.baseNameOf ./.;
  cfg = config.hm.flavors.${name}.${subname}.${subsubname};
in {
  options = {
    hm = {
      flavors = {
        ${name} = {
          ${subname} = {
            ${subsubname} = {
              enable = lib.mkDefaultEnabledOption "Install ${name} Home-Manager flavor.";
            };
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
        terminal = "${pkgs.kitty}/bin/kitty";
      };
    };
  };
}
