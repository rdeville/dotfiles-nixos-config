{lib, ...}: {
  imports = builtins.map (item: ./${item}) (lib.importDir ./.);

  options = {
    hm = {
      flavors = lib.mkOption {
        type = lib.types.submodule {};
        default = {};
      };
    };
  };
}
