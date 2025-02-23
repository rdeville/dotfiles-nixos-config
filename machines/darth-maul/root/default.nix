{lib, ...}: let
  username = builtins.baseNameOf ./.;

  base = import ../base.nix;
  default = import ../../default.nix {inherit username;};
in {
  nixpkgs = {
    config = {
      allowUnfreePredicate = pkg:
        builtins.elem (lib.getName pkg) [
          "zsh-abbr"
        ];
    };
  };

  hm = {
    inherit username;
    inherit (base) hostName system isMain;

    flavors = {
      inherit (default.flavors) _core;
    };
  };
}
