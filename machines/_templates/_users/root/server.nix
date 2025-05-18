{lib, ...}: {
  nixpkgs = {
    config = {
      allowUnfreePredicate = pkg:
        builtins.elem (lib.getName pkg) [
          "zsh-abbr"
        ];
    };
  };

  hm = {
    username = builtins.baseNameOf ./.;
    flavors = {
      _core = {
        fastfetch.enable = false;
        git.enable = false;
        gpg.enable = false;
        lazygit.enable = false;
      };
    };
  };
}
