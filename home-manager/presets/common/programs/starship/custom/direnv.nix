{
  lib,
  colors,
  sep,
  folder,
  ...
}: let
  fg = colors.material-all.orange_300;
  bg = folder.bg; # colors.material-all.grey_900;
  # emphasis
  em = "bold";
in {
  # Disables the module.
  disabled = false;

  # The command whose output should be printed. The command will be passed on
  # stdin to the shell.
  command = "echo ''";
  # Either a boolean value (true or false, without quotes) or a string shell
  # command used as a condition to show the module. In case of a string, the
  # module will be shown if the command returns a 0 status code.
  when = "test -n \"\${DIRENV_DIR}\"";
  # The description of the module that is shown when running starship explain.
  description = "Show a symbol if in an active direnv";
  # The symbol used before displaying the command output.
  symbol = " ";
  # Ignore global command_timeout setting and keep running external commands, no matter how long they take.
  ignore_timeout = false;

  # The style of the module.
  style = "bg:${bg} fg:${fg}";

  # The format for the module.
  format = lib.concatStrings [
    "[ $symbol($output)]($style)"
  ];
}
