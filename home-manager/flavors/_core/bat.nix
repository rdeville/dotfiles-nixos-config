{
  config,
  lib,
  ...
}: let
  name = builtins.baseNameOf ./.;
  subname = "bat";
  cfg = config.hm.flavors.${name};
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
    programs = {
      bat = {
        enable = true;
        config = {
          map-syntax = [];
          pager = "less -FR";
          theme = "TwoDark";
        };
      };

      zsh = let
        aliasAbbr = {
          b = "bat";
        };
      in {
        shellGlobalAliases = {
          B = "| bat ";
          JSON = " | bat -ljson";
          YAML = " | bat -lyaml";
        };

        shellAliases = aliasAbbr;

        zsh-abbr = {
          abbreviations = aliasAbbr;
        };
      };
    };
  };
}
