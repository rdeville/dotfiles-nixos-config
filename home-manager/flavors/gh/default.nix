{
  userCfg,
  config,
  pkgs,
  lib,
  ...
}: let
  moduleCfg = userCfg.flavors.gh;
in {
  options = {
    gh = {
      enable = lib.mkEnableOption "Install gh (GitHub CLI) Related Packages";
    };
  };

  config = lib.mkIf moduleCfg.enable {
    home = {
      packages = with pkgs; [
        gh
      ];
    };

    xdg = {
      configFile = {
        "gh/config.yml" = {
          enable = with pkgs; builtins.elem gh config.home.packages;
          text = pkgs.lib.generators.toYAML {} {
            # What protocol to use when performing git operations.
            # Supported values: ssh, https
            git_protocol = "ssh";
            # When to interactively prompt. This is a global config that cannot be
            # overridden by hostname. Supported values: enabled, disabled
            prompt = "enabled";
            # A pager program to send command output to, e.g. "less". Set the value to
            # "cat" to disable the pager.
            pager = with pkgs;
              if builtins.elem bat config.home.packages
              then "bat"
              else "cat";
          };
        };
      };
    };
  };
}
