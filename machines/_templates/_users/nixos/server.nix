{lib, ...}: {
  hm = {
    username = builtins.baseNameOf ./.;

    flavors = {
      _core = {
        fastfetch.enable = false;
        git.enable = false;
        gpg.enable = false;
        home-manager.enable = false;
        lazygit.enable = false;
        mr.enable = false;
      };
    };
  };
}
