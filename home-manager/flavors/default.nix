{userCfg, ...}: let
  localFlavors = builtins.filter (item: item.value.enable) (builtins.foldl' (acc: elem:
    [
      {
        name = elem;
        value = userCfg.localFlavors.${elem};
      }
    ]
    ++ acc) [] (builtins.attrNames userCfg.localFlavors));

  imports = (
    builtins.foldl' (
      acc: elem:
        [./${elem}] ++ acc
    ) [] (builtins.attrNames (builtins.listToAttrs localFlavors))
  );
in {
  imports = imports;
}
