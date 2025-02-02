{
  config,
  lib,
  pkgs,
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
              config.hm.flavors.${name}.enable;
          };
        };
      };
    };
  };

  config = lib.mkIf cfg.enable {
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
  };
}
