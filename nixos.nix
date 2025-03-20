{
  inputs,
  lib,
  ...
}:
# Deploy using nixos-anywhere
# Slightly experimental: Like generic, but with nixos-facter (https://github.com/numtide/nixos-facter)
# nixos-anywhere --flake .#<hostname> --generate-hardware-config nixos-facter facter.json <hostname>
builtins.foldl' (acc: host:
    {
      "${host}" = inputs.nixpkgs.lib.nixosSystem {
        modules = [
          # Overlay
          ./overlays
          # Local Modules
          ./machines/${host}
          ./nixos
          # External Modules
          inputs.nixos.inputs.sops-nix.nixosModules.sops
          inputs.home-manager.nixosModules.home-manager
          inputs.nixos-facter-modules.nixosModules.facter
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
