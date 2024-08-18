{
  userCfg,
  config,
  pkgs,
  lib,
  ...
}: let
  moduleCfg = userCfg.flavors.glab;
in {
  options = {
    glab = {
      enable = lib.mkEnableOption "Install glab (GitLab CLI) Related Packages";
    };
  };

  config = lib.mkIf moduleCfg.enable {
    home = {
      packages = with pkgs; [
        glab
      ];
    };

    xdg = {
      configFile = {
        "glab-cli/config.yml" = {
          enable = with pkgs; builtins.elem glab config.home.packages;
          text = pkgs.lib.generators.toYAML {} {
            # What protocol to use when performing git operations. Supported values: ssh, https
            git_protocol = "ssh";
            # Set your desired markdown renderer style. Available options are [dark, liglabt, notty] or set a custom style. Refer to https://github.com/charmbracelet/glamour#styles
            glamour_style = "dark";
            # Allow glab to automatically check for updates and notify you when there are new updates
            check_update = "false";
          };
        };
        "glab-cli/aliases.yml" = {
          enable = with pkgs; builtins.elem glab config.home.packages;
          text = pkgs.lib.generators.toYAML {} {
            ci = "pipeline ci";
            co = "mr checkout";
          };
        };
      };
    };
  };
}
