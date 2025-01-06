{
  extraConfig,
  lib,
  os,
  ...
}: {
  imports = builtins.map (item: ./${item}) (lib.importDir ./.);

  config =
    extraConfig
    // {
      inherit os;
    };
}
