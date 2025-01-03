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
        opentofu
        hclfmt
        terraform-docs
      ];
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
