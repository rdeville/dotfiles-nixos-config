{
  config,
  userCfg,
  pkgs,
  ...
}: {
  home = {
    username = userCfg.username;

    homeDirectory =
      if "homeDirectory" ? userCfg
      then userCfg.homeDirectory
      else "/home/${userCfg.username}";

    preferXdgDirectories = true;

    sessionPath = [
      "$HOME/.local/share/bin"
      "$HOME/.local/bin"
    ];

    sessionVariables = {
      HOST = userCfg.hostname;
      SHELL_DIR = "$HOME/.config/shell";
      EDITOR = "nvim";
    };
  };
}
