{...}: {
  hm = {
    username = builtins.baseNameOf ./.;
    flavors = {
      _core = {
        fastfetch.enable = false;
        git.enable = false;
        gpg.enable = false;
        lazygit.enable = false;
      };
      tmux.enable = true;
    };
  };
}
