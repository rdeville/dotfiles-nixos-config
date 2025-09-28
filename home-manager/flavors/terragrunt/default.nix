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
        initContent = lib.mkBefore ''
          autoload -U +X bashcompinit && bashcompinit
          complete -o nospace -C "$(command -v terragrunt)" terragrunt
        '';

        zsh-abbr = {
          abbreviations = {
            tga = "terragrunt apply";
            tgf = "terragrunt run -- fmt";
            tgi = "terragrunt init";
            tgo = "terragrunt output";
            tgp = "terragrunt plan";
            tgv = "terragrunt validate";
            tgs = "terragrunt state";
            tgssh = "terragrunt state show";
            tgsh = "terragrunt show";

            tgaa = "terragrunt apply --all";
            tgfa = "terragrunt run --all -- fmt";
            tgia = "terragrunt init --all";
            tgoa = "terragrunt output --all";
            tgpa = "terragrunt plan --all";
            tgva = "terragrunt validate --all";
            tgsha = "terragrunt show --all";
          };
        };
      };
    };
  };
}
