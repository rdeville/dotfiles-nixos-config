{
  config,
  lib,
  ...
}: let
  keyFile = "${config.xdg.cacheHome}/.age.key";
in {
  sops = {
    age = {
      inherit keyFile;
    };
  };

  nixpkgs = {
    config = {
      allowUnfreePredicate = pkg:
        builtins.elem (lib.getName pkg) [
          "zsh-abbr"
        ];
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
    };
  };
}
