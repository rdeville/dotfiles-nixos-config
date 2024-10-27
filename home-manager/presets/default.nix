{userCfg, ...}: let
  userPresets =
    if userCfg ? presets
    then userCfg.presets
    else {};

  presets = builtins.filter (
    item: userPresets.${item}.enable
  ) (builtins.attrNames userPresets);

  imports = builtins.map (elem: ./${elem}) presets;
in {
  imports = imports;
}
