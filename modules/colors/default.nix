{lib, ...}: {
  imports = builtins.map (item: ./${item}) (lib.importDir ./.);

  options = {
    colors = lib.mkOption {
      type = lib.types.attrs;
      description = "Object storing colors";
      default = {};
    };
  };
}
