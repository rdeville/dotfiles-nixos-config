{
  userCfg,
  config,
  lib,
  pkgs,
  ...
}: let
  moduleCfg =
    if userCfg.flavors ? opentofu
    then userCfg.flavors.opentofu
    else {
      enable = false;
    };
in {
  options = {
    opentofu = {
      enable = lib.mkEnableOption "Install opentofu Related Packages";
    };
  };

  config = lib.mkIf moduleCfg.enable {
    home = {
      packages = with pkgs; [
        opentofu
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
