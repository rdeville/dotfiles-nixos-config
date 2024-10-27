{userCfg, ...}: let
  userFlavors =
    if userCfg ? flavors
    then userCfg.flavors
    else {};

  flavors = builtins.filter (
    item: userFlavors.${item}.enable
  ) (builtins.attrNames userFlavors);

  imports = builtins.map (elem: ./${elem}) flavors;
in {
  imports = imports;
}
