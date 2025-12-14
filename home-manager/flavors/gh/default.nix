{
  config,
  pkgs,
  lib,
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

          gh-dash = {
            enable = lib.mkDefaultEnabledOption "Install gh-dash package and config";

            settings = lib.mkOption {
              inherit ((pkgs.formats.yaml {})) type;
              default = {};
              example = lib.literalExpression ''
                {
                  prSections = [{
                    title = "My Pull Requests";
                    filters = "is:open author:@me";
                  }];
                }
              '';
              description = ''
                Configuration written to {file}`$XDG_CONFIG_HOME/gh-dash/config.yml`.
              '';
            };
          };
        };
      };
    };
  };

  config = lib.mkIf cfg.enable {
    programs = {
      gh = {
        inherit (cfg) enable;
        settings = {
          git_protocol = "ssh";
          # When to interactively prompt. This is a global config that cannot be
          # overridden by hostname. Supported values: enabled, disabled
          prompt = "enabled";
          # A pager program to send command output to, e.g. "less". Set the value to
          # "cat" to disable the pager.
          pager = pkgs.bat;
        };
      };
      inherit (cfg) gh-dash;
    };
  };
}
