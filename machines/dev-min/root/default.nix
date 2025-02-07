{...}: let
  username = builtins.baseNameOf ./.;

  base = import ../base.nix;
in {
  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  hm = {
    inherit username;
    inherit (base) hostName system;

    flavors = {
      _core = {
        enable = false;
      };
    };
  };
}
