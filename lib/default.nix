inputs: lib: let
  debug = data: builtins.trace (builtins.toJSON data);

  importDir = inode: (builtins.filter (
    item: (item != "default.nix")
  ) (listInodes inode));

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
    debug
    importDir
    listDirs
    listFiles
    mkDefaultEnabledOption
    nixGLWrap
    pkgsForSystem
    ;
}
