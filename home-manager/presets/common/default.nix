{
  mkLib,
  colors,
  ...
}: {
  imports =
    (mkLib.mkImportDir ./programs)
    ++ (mkLib.mkImportDir ./xdg);
}
