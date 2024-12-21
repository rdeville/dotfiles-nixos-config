{lib, ...}: {
  imports = builtins.map (item: ./${item}) (lib.importDir ./.);

  options = {
    hm = {
      presets = lib.mkOption {
        type = lib.types.submodule {};
        default = {};
      };
    };
  };
}
