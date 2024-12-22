{
  lib,
  colors,
  sep,
  ...
}: let
  bg = colors.material-all.grey_800;
  fg = colors.material-all.grey_100;
  # emphasis
  em = "bold";
in {
  # Disables the module.
  disabled = false;

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
  style = "${em} bg:${bg} fg:${fg}";

  # The format for the module.
  format = lib.concatStrings [
    "[ $indicator]($style)"
  ];
}
