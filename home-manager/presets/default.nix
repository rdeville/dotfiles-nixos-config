{userCfg, ...}: let
  presets = builtins.filter (item: item.value.enable) (builtins.foldl' (acc: elem:
    [
      {
        name = elem;
        value = userCfg.presets.${elem};
      }
    ]
    ++ acc) [] (builtins.attrNames userCfg.presets));

  imports = (
    builtins.foldl' (
      acc: elem:
        [./${elem}] ++ acc
    ) [] (builtins.attrNames (builtins.listToAttrs presets))
  );
in {
  inherit imports;
}
