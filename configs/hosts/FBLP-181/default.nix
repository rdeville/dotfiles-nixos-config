{...}: let
  base = import ./base.nix;
in {
  os = {
    inherit (base) hostName system isGui isMain isDarwin;
  };
}
