{
  inputs,
  lib,
  ...
}: let
  prod = [
    "kenobi"
    "lilith"
    "ava"
    "maya"
  ];
in
  # Deploy using nixos-anywhere
  # Slightly experimental: Like generic, but with nixos-facter (https://github.com/numtide/nixos-facter)
  # nixos-anywhere --flake .#<hostname> --generate-hardware-config nixos-facter facter.json <hostname>
  builtins.foldl' (acc: host: let
    release =
      if builtins.elem host prod
      then {
        nixpkgs = inputs.nixpkgs-stable;
        nixos = inputs.nixos-stable;
        microvm = inputs.microvm-stable;
        isProd = true;
      }
      else {
        nixpkgs = inputs.nixpkgs;
        nixos = inputs.nixos;
        microvm = inputs.microvm;
        isProd = false;
      };
  in
    {
      "${host}" = release.nixpkgs.lib.nixosSystem {
        modules = [
          # Overlay
          ./overlays
          # External Modules
          inputs.sops-nix.nixosModules.sops
          inputs.home-manager.nixosModules.home-manager
          inputs.nixos-facter-modules.nixosModules.facter
          inputs.nix-topology.nixosModules.default
          # Internal Modules
          release.nixos.nixosModules.os
          release.microvm.nixosModules.host
          # Local Modules
          ./machines/${host}
          ./nixos
          {
            config = {
              os = {
                inherit (release) isProd;
              };
            };
          }
        ];
        specialArgs = {
          inherit inputs lib;
        };
      };
    }
    // acc) {}
  lib.getValidHosts
