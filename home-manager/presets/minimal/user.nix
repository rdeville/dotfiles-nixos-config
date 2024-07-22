{
  userCfg,
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
      EDITOR = "nvim";
    };
  };
}
