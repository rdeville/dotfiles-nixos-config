{
  config,
  lib,
  ...
}: let
  name = "git_symbol";
  cfg = mkLib.mkGetSarshipModuleConfig name;
  mkLib = import ../../lib.nix {inherit config;};

  sep = mkLib.sep.${cfg.position};
  bg = mkLib.colors.brown_500;
  fg = mkLib.colors.red_500;
in {
  options = mkLib.mkSetStarshipModuleOptions name {
    disabled = lib.mkEnableOption "Disable starship ${name} module.";

    position = lib.mkOption {
      type = lib.types.str;
      description = "Position of the module (right or left)";
      default = "left";
    };
  };

  config = {
    programs = {
      starship = {
        settings = {
          custom = {
            ${name} = {
              inherit
                (cfg)
                disabled
                ;
              # Either a boolean value (true or false, without quotes) or a string shell
              # command used as a condition to show the module. In case of a string, the
              command = "echo ''";
              # module will be shown if the command returns a 0 status code.
              when = true;
              # If true, the module will only be shown in paths containing a
              # (git) repository. This option alone is not sufficient display
              # condition in absence of other options.
              require_repo = true;
              # Ignore global command_timeout setting and keep running external commands, no matter how long they take.
              ignore_timeout = false;
              style = "fg:${fg} bg:${bg}";
              symbol = " ";
              # The format for the module.
              format = lib.concatStrings [
                (sep bg)
                "[ $symbol]($style)"
              ];
            };
          };
        };
      };
    };
  };
}
