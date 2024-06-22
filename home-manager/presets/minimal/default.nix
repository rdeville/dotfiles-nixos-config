{mkLib, ...}: {
  imports =
    [
      ./user.nix
    ]
    ++ (mkLib.mkImportDir ./programs);
}
