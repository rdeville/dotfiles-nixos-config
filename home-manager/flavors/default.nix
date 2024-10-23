{userCfg, ...}: let
  flavors = builtins.filter (item: item.value.enable) (builtins.foldl' (acc: elem:
    [
      {
        name = elem;
        value = userCfg.flavors.${elem};
      }
    ]
    ++ acc) [] (builtins.attrNames userCfg.flavors));

  imports = (
    builtins.foldl' (
      acc: elem:
        [./${elem}] ++ acc
    ) [] (builtins.attrNames (builtins.listToAttrs flavors))
  );
in {
  imports = imports;
}
