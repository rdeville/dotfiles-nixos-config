{
  config,
  lib,
  pkgs,
  ...
}: let
  name = builtins.baseNameOf ../.;
  cfg = config.hm.flavors.${name};
in
  lib.mkIf cfg.enable {
    home = {
      packages = with pkgs; [
        tmuxp # Tmux Manager
      ];
    };

    xdg = {
      configFile = {
        "tmuxp/default.yaml" = {
          enable = true;
          source = ./default.yaml;
        };
        "tmuxp/home.yaml" = {
          enable = true;
          source = ./home.yaml;
        };
      };
    };
  }
