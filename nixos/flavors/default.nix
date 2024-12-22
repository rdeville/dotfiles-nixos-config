{lib, ...}: {
  imports = builtins.map (item: ./${item}) (lib.importDir ./.);

  options = {
    os = {
      flavors = lib.mkOption {
        type = lib.types.submodule {};
        description = "Install NixOS flavors.";
        default = {};
      };
    };
  };
}
