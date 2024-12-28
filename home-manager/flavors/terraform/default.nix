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
        terraform
      ];
    };

    xdg = {
      configFile = {
        "terraform/terraformrc" = {
          enable = with pkgs; builtins.elem terraform config.home.packages;
          text = ''
            plugin_cache_dir = "${config.xdg.cacheHome}/terraform/plugins"
          '';
        };
      };
    };
  };
}
