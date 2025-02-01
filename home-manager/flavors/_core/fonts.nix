{
  config,
  lib,
  pkgs,
  ...
}: let
  name = builtins.baseNameOf ./.;
  subname = "fonts";
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

  config = lib.mkIf cfg.enable {
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
          monospace = ["FiraCode Nerd Font"];
          sansSerif = ["FiraCode Nerd Font"];
          serif = ["FiraCode Nerd Font"];
        };
      };
    };
  };
}
