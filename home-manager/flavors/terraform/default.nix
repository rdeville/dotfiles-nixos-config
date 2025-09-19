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
        terraform
        terraform-docs
      ];
    };

    programs = {
      zsh = {
        initContent = lib.mkBefore ''
          autoload -U +X bashcompinit && bashcompinit
          complete -o nospace -C "$(command -v terraform)" terraform
        '';

        zsh-abbr = {
          abbreviations = {
            tf = "terraform";
            tfa = "terraform apply";
            tff = "terraform fmt";
            tfi = "terraform init";
            tfo = "terraform output";
            tfp = "terraform plan";
            tfv = "terraform validate";
            tfs = "terraform state";
            tfssh = "terraform state show";
            tfsh = "terraform show";
            tfw = "terraform workspace";
          };
        };
      };
    };

    xdg = {
      configFile = {
        "terraform/terraformrc" = {
          enable = true;
          text = ''
            plugin_cache_dir = "${config.xdg.cacheHome}/terraform/plugins"
          '';
        };
      };
    };
  };
}
