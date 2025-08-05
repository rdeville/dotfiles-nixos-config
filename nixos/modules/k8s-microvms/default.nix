{lib, ...}: {
  options = {
    k8s-microvms = lib.mkOption {
      description = "Configure k8s microvms.";
      default = {};
      type = lib.types.attrsOf (lib.types.submodule (import ./options.nix));
    };
  };

  imports = [
    ./hosts.nix
  ];
}
