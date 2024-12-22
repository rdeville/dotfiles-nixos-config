{
  lib,
  colors,
  sep,
  ...
}: let
  fg = colors.material-all.white;
  bg = colors.material-all.red_500;
  default_bg = colors.material-all.grey_900;
in {
  # Enable the module
  disabled = false;
  # The symbol displayed on program error
  symbol = " ";
  # The symbol displayed on program success
  success_symbol = "";
  # The symbol displayed when file isn't executable
  not_executable_symbol = "󰳧 ";
  # The symbol displayed when the command can't be found
  not_found_symbol = " ";
  # The symbol displayed on SIGINT (Ctrl + c)
  sigint_symbol = "󰟾 ";
  # The symbol displayed on any signal
  signal_symbol = "󰠠 ";
  # Enable signal mapping from exit code
  recognize_signal_code = false;
  # Enable symbols mapping from exit code
  map_symbol = true;
  # Enable pipestatus reporting
  pipestatus = false;
  # The style for the module.
  style = "bold bg:${bg} fg:${fg}";
  # The format of the module
  format = lib.concatStrings [
    "[${sep.right}](bg:${sep.clr} fg:${bg})"
    "[ $symbol$int ]($style)"
    "[${sep.right}](fg:${sep.clr} bg:${bg})"
  ];
}
