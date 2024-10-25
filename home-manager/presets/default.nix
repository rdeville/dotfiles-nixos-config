{userCfg, ...}: let
  localPresets = builtins.filter (item: item.value.enable) (builtins.foldl' (acc: elem:
    [
      {
        name = elem;
        value = userCfg.localPresets.${elem};
      }
    ]
    ++ acc) [] (builtins.attrNames userCfg.localPresets));

  imports = (
    builtins.foldl' (
      acc: elem:
        [./${elem}] ++ acc
    ) [] (builtins.attrNames (builtins.listToAttrs localPresets))
  );
in {
  imports = imports;
}
