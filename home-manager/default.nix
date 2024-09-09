{
  userCfg,
  mkLib,
  ...
}: let
  main =
    if userCfg.presets.main
    then [./presets/main]
    else [];
  imports = main;
in {
  imports = imports ++ (mkLib.mkImportDir ./flavors);
}
