{mkLib, ...}: let
  imports = builtins.map (item: ./${item}) ((builtins.filter (
      item:
        item != "default.nix"
    ) (mkLib.mkListFiles ./.))
    ++ (mkLib.mkListDirs ./.));
in {
  imports = imports;
}
