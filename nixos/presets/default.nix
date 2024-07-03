{
  inputs,
  ...
}:
let
  mkLib = import ../../lib {inherit inputs;};
in
{
  imports =
    (mkLib.mkImportDir ./base)
    ++ (mkLib.mkImportDir ./common)
    ++ (mkLib.mkImportDir ./gui);
}
