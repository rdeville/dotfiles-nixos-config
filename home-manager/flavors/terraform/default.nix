{
  userCfg,
  config,
  lib,
  pkgs,
  ...
}: let
  moduleCfg =
    if userCfg.flavors ? terraform
    then userCfg.flavors.terraform
    else {
      enable = false;
    };
in {
  options = {
    terraform = {
      enable = lib.mkEnableOption "Install Terraform Related Packages";
    };
  };

  config = lib.mkIf moduleCfg.enable {
    home = {
      packages = with pkgs; [
        terraform
      ];
    };

    nix = {
      settings = {
        allowUnfree = true;
      };
    };

    xdg = {
      configFile = {
        "terraform/terraformrc" = {
          enable = with pkgs; builtins.elem terraform config.home.packages;
          text = ''
            plugin_cache_dir = "$HOME/.cache/terraform/plugins"
          '';
        };
      };
    };
  };
}
