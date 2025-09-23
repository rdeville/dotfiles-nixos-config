{
  config,
  lib,
  pkgs,
  ...
}: let
  name = builtins.baseNameOf ../../.;
  subname = builtins.baseNameOf ../.;
  subsubname = builtins.baseNameOf ./.;
  cfg = config.hm.flavors.${name}.${subname}.${subsubname};
in {
  options = {
    hm = {
      flavors = {
        ${name} = {
          ${subname} = {
            ${subsubname} = {
              enable =
                lib.mkDependEnabledOption ''
                  Install ${name}.${subname} Home-Manager flavor.
                ''
                (
                  config.hm.flavors.${name}.enable
                  && config.hm.flavors.${name}.${subname}.enable
                );
            };
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

    programs = {
      zsh = {
        zsh-abbr = {
          abbreviations = {
            # Tmuxp
            tl = "tmuxp load -y";
            tld = "tmuxp load -y \${TMUXP_CONFIG:-default}";
          };
        };
      };
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
