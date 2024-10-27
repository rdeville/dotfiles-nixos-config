{userCfg, ...}: let
  userPresets =
    if userCfg ? localPresets
    then userCfg.localPresets
    else {};

  presets = builtins.filter (
    item: userPresets.${item}.enable
  ) (builtins.attrNames userPresets);

  imports = builtins.map (elem: ./${elem}) presets;
in {
  imports = imports;
}
