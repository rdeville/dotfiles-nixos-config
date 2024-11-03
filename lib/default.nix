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

  mkListDirs = inode:
    builtins.map (elem: elem.name) (
      builtins.filter (inode: inode.value == "directory") (
        builtins.map (key: {
          name = key;
          value = builtins.getAttr key (builtins.readDir inode);
        })
        (builtins.attrNames (builtins.readDir inode))
      )
    );

  mkListFiles = inode:
    builtins.map (elem: elem.name) (
      builtins.filter (inode: inode.value == "regular") (
        builtins.map (key: {
          name = key;
          value = builtins.getAttr key (builtins.readDir inode);
        })
        (builtins.attrNames (builtins.readDir inode))
      )
    );
in {
  inherit
    mkDebug
    mkImportDir
    mkListDirs
    mkListFiles
    pkgsForSystem
    ;
}
