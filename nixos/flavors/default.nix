{hostCfg, ...}: let
  flavors = builtins.filter (item: item.value.enable) (builtins.foldl' (acc: elem:
    [
      {
        name = elem;
        value = hostCfg.flavors.${elem};
      }
    ]
    ++ acc) [] (builtins.attrNames hostCfg.flavors));

  imports = (
    builtins.foldl' (
      acc: elem:
        [./${elem}] ++ acc
    ) [] (builtins.attrNames (builtins.listToAttrs flavors))
  );
in {
  imports = imports;
}
