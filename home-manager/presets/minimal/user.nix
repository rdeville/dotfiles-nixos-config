{userCfg, ...}: {
  home = {
    username = userCfg.username;

    homeDirectory =
      if userCfg ? home
      then userCfg.home
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
