{
  config,
  lib,
  pkgs,
  ...
}: let
  name = builtins.baseNameOf ./.;
  subname = "viddy";
  cfg = config.hm.flavors.${name}.${subname};
in {
  options = {
    hm = {
      flavors = {
        ${name} = {
          ${subname} = {
            enable =
              lib.mkDependEnabledOption ''
                Install ${name}.${subname} Home-Manager flavor.
              ''
              config.hm.flavors.${name}.enable;
          };
        };
      };
    };
  };

  config = lib.mkIf cfg.enable {
    home = {
      packages = with pkgs; [
        viddy # A better watcher
      ];
    };

    programs = {
      zsh = {
        shellGlobalAliases = {
          W = "viddy ";
        };

        shellAliases = {
          viddy = "viddy -D";
          watch = "viddy";
        };
      };
    };

    xdg = {
      configFile = {
        "viddy.toml" = {
          text = ''
            [general]
            no_shell = false
            shell = "zsh"
            shell_options = "--login"
            skip_empty_diffs = false
            disable_mouse = true

            # vim: ft=toml
          '';
        };
      };
    };
  };
}
