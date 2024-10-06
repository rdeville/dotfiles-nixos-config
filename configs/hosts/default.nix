{lib, ...}: (
  builtins.listToAttrs (
    builtins.map (inode: {
      name = inode;
      value = import ./${inode} {inherit lib;};
    })
    (lib.mkListDirs ./.)
  )
)
