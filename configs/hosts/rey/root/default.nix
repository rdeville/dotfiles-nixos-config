{...}: let
  username = builtins.baseNameOf ./.;

  os = (import ../default.nix {}).os;
  default = import ../../default.nix {inherit username;};
  isGui =
    if os ? isGui
    then os.isGui
    else false;
  isMain =
    if os ? isMain
    then os.isMain
    else false;
in {
  extraConfig = {};

  hm = {
    inherit username isGui isMain;
    inherit (os) hostname;
    flavors = {
      inherit (default.flavors) _core;
    };
  };
}
