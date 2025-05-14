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
    username = "nixos";
    flavors = {
      _core = {
        git = {
          enable = false;
        };

        gpg = {
          enable = false;
        };

        fastfetch = {
          enable = false;
        };

        lazygit = {
          enable = false;
        };
      };
    };
  };
}
