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
        opentofu
        terraform-docs
      ];
    };

    programs = {
      zsh = {
        initExtra = ''
          autoload -U +X bashcompinit && bashcompinit
          complete -o nospace -C "$(command -v opentofu)" opentofu
        '';

        zsh-abbr = {
          abbreviations = {
            to = "opentofu";
            toa = "opentofu apply";
            tof = "opentofu fmt";
            toi = "opentofu init";
            too = "opentofu output";
            top = "opentofu plan";
            tov = "opentofu validate";
            tos = "opentofu state";
            tossh = "opentofu state show";
            tosh = "opentofu show";
            tow = "opentofu workspace";
          };
        };
      };
    };

    xdg = {
      configFile = {
        "opentofu/terraformrc" = {
          enable = with pkgs; builtins.elem opentofu config.home.packages;
          text = ''
            plugin_cache_dir = "$HOME/.cache/opentofu/plugins"
          '';
        };
      };
    };
  };
}
