{
  inputs,
  lib,
  ...
}:
builtins.foldl' (acc: host:
    {
      "${host}" = inputs.nixpkgs.lib.nixosSystem {
        modules = [
          # Local Modules
          ./machines/${host}
          ./nixos
          # External Modules
          inputs.nixos.inputs.sops-nix.nixosModules.sops
          inputs.home-manager.nixosModules.home-manager
          # Internal Modules
          inputs.nixos.nixosModules.os
        ];
        specialArgs = {
          inherit inputs lib;
        };
      };
    }
    // acc) {} (
  builtins.filter (host: (
    host != "keys" && host != "assets"
  )) (lib.listDirs ./machines)
)
