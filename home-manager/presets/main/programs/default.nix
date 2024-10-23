{inputs, ...}: let
  mkLib = import ../../../../lib/default.nix {inherit inputs;};

  imports = builtins.map (item: ./${item}) ((builtins.filter (
      item:
        item != "default.nix"
    ) (mkLib.mkListFiles ./.))
    ++ (mkLib.mkListDirs ./.));
in {
  imports = imports;
}
