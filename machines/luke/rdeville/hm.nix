{...}: let
  username = builtins.baseNameOf ./.;
  base = import ../base.nix;
  default = import ../../default.nix {inherit username;};
in {
  hm = {
    inherit username;
    inherit (base) hostName system isMain;

    flavors = {
      inherit (default.flavors) _core;

      _gui = {
        enable = base.isGui;
        wayland = {
          enable = true;
        };
      };

      audio = {
        enable = true;
      };

      bluetooth = {
        enable = true;
      };
    };
  };
}
