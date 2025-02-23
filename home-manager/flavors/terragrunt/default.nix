{
  config,
  lib,
  pkgs,
  ...
}: let
  name = builtins.baseNameOf ./.;
  cfg = config.hm.flavors.${name};
in {
  options = {
    hm = {
      flavors = {
        ${name} = {
          enable = lib.mkEnableOption "Install ${name} Home-Manager flavor.";
        };
      };
    };
  };

  config = lib.mkIf cfg.enable {
    home = {
      packages = with pkgs; [
        hclfmt
        terragrunt
      ];
    };

    programs = {
      zsh = let
        aliasAbbr = {
          tg = "terragrunt";
          tgra = "terragrunt run-all";
        };
      in {
        initExtra = ''
          autoload -U +X bashcompinit && bashcompinit
          complete -o nospace -C "$(command -v terragrunt)" terragrunt
        '';

        shellAliases = aliasAbbr;

        zsh-abbr = {
          abbreviations =
            aliasAbbr
            // {
              tga = "tg apply";
              tgf = "tg fmt";
              tgi = "tg init";
              tgo = "tg output";
              tgp = "tg plan";
              tgv = "tg validate";
              tgs = "tg state";
              tgssh = "tg state show";
              tgsh = "tg show";

              tgraa = "tgra apply";
              tgraf = "tgra fmt";
              tgrai = "tgra init";
              tgrao = "tgra output";
              tgrap = "tgra plan";
              tgrav = "tgra validate";
              tgras = "tgra state";
              tgrassh = "tgra state show";
              tgrash = "tgra show";
            };
        };
      };
    };
  };
}
