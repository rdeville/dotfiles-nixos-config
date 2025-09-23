{config, ...}: let
  keyFile = "${config.xdg.cacheHome}/.age.key";
in {
  sops = {
    age = {
      inherit keyFile;
    };
  };

  programs = {
    home-manager = {
      enable = true;
    };
  };

  hm = {
    username = builtins.baseNameOf ./.;
    flavors = {
      _core = {
        fastfetch.enable = false;
        gpg.enable = false;
        home-manager.enable = false;
        lazygit.enable = false;
        git.enable = false;
        mr.enable = false;
      };
      tmux.enable = true;
    };
  };
}
