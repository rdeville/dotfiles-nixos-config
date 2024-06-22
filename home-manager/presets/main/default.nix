{mkLib, ...}: {
  imports = (mkLib.mkImportDir ./programs) ++ (mkLib.mkImportDir ./xdg);
}
