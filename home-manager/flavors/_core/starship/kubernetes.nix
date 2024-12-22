{
  lib,
  colors,
  sep,
  ...
}: let
  fg = colors.material-all.grey_100;
  bg = colors.material-all.blue_700;
in {
  # Disables the username module.
  disabled = false;

  # A format string representing the symbol displayed before the Cluster.
  symbol = "󱃾 ";
  # Which extensions should trigger this module.
  detect_extensions = [];
  # Which filenames should trigger this module.
  detect_files = [];
  # Which folders should trigger this modules.
  detect_folders = [];
  # Which environmental variables should trigger this module
  detect_env_vars = ["KUBECONFIG"];
  # Customized styles and symbols for specific contexts.
  contexts = [
    # {
    #   # Required Regular expression to match current Kubernetes context name.
    #   context_pattern = "";
    #   # Regular expression to match current Kubernetes user name.
    #   user_pattern = "";
    #   # Context alias to display instead of the full context name.
    #   context_alias = "";
    #   # User alias to display instead of the full user name.
    #   user_alias = "";
    #   # The style for the module when using this context. If not set, will use module's style.
    #   style = ""
    #   # The symbol for the module when using this context. If not set, will use module's symbol.
    #   symbol = "";
    # };
  ];

  # The style used for the module
  style = "bg:${bg} fg:${fg}";

  #The format for the module.
  format = lib.concatStrings [
    "[${sep.right}](bg:${sep.clr} fg:${bg})"
    "[ $symbol$user@$cluster $context:$namespace ]($style)"
    "[${sep.right}](bg:${bg} fg:${sep.clr})"
  ];
}
