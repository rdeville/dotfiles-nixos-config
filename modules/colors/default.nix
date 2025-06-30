{lib, ...}: {
  imports = [
    ./material.nix
  ];

  options = {
    colors = lib.mkOption {
      type = lib.types.attrs;
      description = "Object storing colors";
      default = {};
    };
  };
}
