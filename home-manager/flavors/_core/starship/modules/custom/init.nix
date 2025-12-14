{
  config,
  lib,
  ...
}: let
  name = "init";
  cfg = mkLib.mkGetSarshipModuleConfig name;
  mkLib = import ../../lib.nix {inherit config;};

  inherit (mkLib.colors) black;
in {
  options = mkLib.mkSetStarshipModuleOptions name {
    disabled = lib.mkEnableOption "Disable starship ${name} module.";
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
              # Ignore global command_timeout setting and keep running external commands, no matter how long they take.
              ignore_timeout = false;
              style = "fg:${black} bg:${black}";
              symbol = "​";
              # The format for the module.
              format = lib.concatStrings [
                "[$symbol]($style)"
              ];
            };
          };
        };
      };
    };
  };
}
