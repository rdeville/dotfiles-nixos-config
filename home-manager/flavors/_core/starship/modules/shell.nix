{
  config,
  lib,
  ...
}: let
  name = "shell";
  cfg = mkLib.mkGetSarshipModuleConfig name;
  mkLib = import ../lib.nix {inherit config;};

  sep = mkLib.sep.${cfg.position};
  bg = mkLib.colors.grey_800;
  fg = mkLib.colors.grey_100;
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
          ${name} = {
            inherit
              (cfg)
              disabled
              ;
            # A format string used to represent bash.
            bash_indicator = ">_";
            # A format string used to represent fish.
            fish_indicator = "?_";
            # A format string used to represent zsh.
            zsh_indicator = "%_";
            # A format string used to represent powershell.
            powershell_indicator = "?_";
            # A format string used to represent pwsh.
            pwsh_indicator = "?_";
            # A format string used to represent ion.
            ion_indicator = "?_";
            # A format string used to represent elvish.
            elvish_indicator = "?_";
            # A format string used to represent tcsh.
            tcsh_indicator = "?_";
            # A format string used to represent xonsh.
            xonsh_indicator = "?_";
            # A format string used to represent cmd.
            cmd_indicator = "?_";
            # A format string used to represent nu.
            nu_indicator = "?_";
            # The default value to be displayed when the shell is unknown.
            unknown_indicator = "?_";
            # The style of the module.
            style = "bold bg:${bg} fg:${fg}";
            # The format for the module.
            format = lib.concatStrings [
              (sep bg)
              "[ $indicator]($style)"
            ];
          };
        };
      };
    };
  };
}
