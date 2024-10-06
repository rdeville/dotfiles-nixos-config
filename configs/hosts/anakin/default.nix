{lib, ...}: let
  presets = {
    sudo = true;
    main = true;
    gui = true;
  };
in {
  presets = presets;
  users = builtins.listToAttrs (
    builtins.map (inode: {
      name = inode;
      value = import ./${inode} {inherit lib presets;};
    })
    (lib.mkListDirs ./.)
  );
}
