{
  config,
  lib,
  os,
  ...
}: {
  imports = builtins.map (item: ./${item}) (lib.importDir ./.);

  config = {
    inherit os;

    nixpkgs = {
      config = {
        allowUnfree = true;
      };
    };
  };
}
