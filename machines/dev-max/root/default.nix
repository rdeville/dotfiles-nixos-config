_: let
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
    inherit (base) hostName system stateVersion;

    flavors = {
      _core = {
        enable = true;
      };
    };
  };
}
