inputs: lib: let
  mkDebug = data: builtins.trace (builtins.toJSON data);
  mkWarn = data: lib.warn (builtins.toJSON data);

  listDirs = inode:
    builtins.map (elem: elem.name) (
      builtins.filter (inode: inode.value == "directory") (
        builtins.map (key: {
          name = key;
          value = builtins.getAttr key (builtins.readDir inode);
        })
        (builtins.attrNames (builtins.readDir inode))
      )
    );

  listFiles = inode:
    builtins.map (elem: elem.name) (
      builtins.filter (inode: inode.value == "regular") (
        builtins.map (key: {
          name = key;
          value = builtins.getAttr key (builtins.readDir inode);
        })
        (builtins.attrNames (builtins.readDir inode))
      )
    );

  listInodes = inode: (listFiles inode) ++ (listDirs inode);

  mkDefaultEnabledOption = description:
    lib.mkOption {
      inherit description;
      type = lib.types.bool;
      default = true;
    };

  mkDependEnabledOption = description: default:
    lib.mkOption {
      inherit description default;
      type = lib.types.bool;
    };

  nixGLWrap = pkg: nixpkgs:
    nixpkgs.runCommand "${pkg.name}-nixgl-wrapper" {} ''
      mkdir $out
      ln -s ${pkg}/* $out
      rm $out/bin
      mkdir $out/bin
      for bin in ${pkg}/bin/*; do
       wrapped_bin=$out/bin/$(basename $bin)
       echo "exec ${nixpkgs.lib.getExe' nixpkgs.nixgl.auto.nixGLDefault "nixGL"} $bin \"\$@\"" > $wrapped_bin
      chmod +x $wrapped_bin
      done
    '';

  pkgsForSystem = system:
    import inputs.nixpkgs {
      inherit system;
      overlays = [inputs.nixgl.overlay];
    };
in {
  inherit
    mkDebug
    mkWarn
    listDirs
    listFiles
    listInodes
    mkDefaultEnabledOption
    mkDependEnabledOption
    nixGLWrap
    pkgsForSystem
    ;
}
