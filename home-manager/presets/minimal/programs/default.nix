{lib, ...}: {
  imports = builtins.map (item: ./${item}) (lib.importDir ./.);
}
