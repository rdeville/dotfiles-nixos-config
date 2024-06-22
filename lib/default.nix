{inputs, ...}: let
  pkgsForSystem = system:
    import inputs.nixpkgs {
      inherit system;
      overlays = [inputs.nixgl.overlay];
      config = {
        allowUnfree = true;
      };
    };

  mkDebug = data: builtins.trace (builtins.toJSON data);

  mkImportDir = dir:
    if builtins.pathExists dir
    then
      builtins.map (
        file: "${dir}/${file}"
      ) (builtins.attrNames (builtins.readDir dir))
    else [];

  lib = {
    inherit
      mkDebug
      mkImportDir
      pkgsForSystem
      ;
  };
in
  lib
