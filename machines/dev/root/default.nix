{...}: let
  username = builtins.baseNameOf ./.;

  base = import ../base.nix;
in {
  hm = {
    inherit username;
    inherit (base) hostName system;

    flavors = {
      _core = {
        enable = true;
      };
    };
  };
}
