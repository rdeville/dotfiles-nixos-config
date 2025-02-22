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
      zsh = {
        initExtra = ''
          autoload -U +X bashcompinit && bashcompinit
          complete -o nospace -C "$(command -v terragrunt)" terragrunt
        '';

        zsh-abbr = {
          abbreviations = {
            tg = "terragrunt";
            tga = "terragrunt apply";
            tgf = "terragrunt fmt";
            tgi = "terragrunt init";
            tgo = "terragrunt output";
            tgp = "terragrunt plan";
            tgv = "terragrunt validate";
            tgs = "terragrunt state";
            tgssh = "terragrunt state show";
            tgsh = "terragrunt show";

            tgra = "terragrunt run-all";
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
