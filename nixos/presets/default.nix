{hostCfg, ...}: let
  presets = builtins.filter (item: item.value.enable) (builtins.foldl' (acc: elem:
    [
      {
        name = elem;
        value = hostCfg.presets.${elem};
      }
    ]
    ++ acc) [] (builtins.attrNames hostCfg.presets));

  imports = (
    builtins.foldl' (
      acc: elem:
        [./${elem}] ++ acc
    ) [] (builtins.attrNames (builtins.listToAttrs presets))
  );
in {
  imports = imports;
}
