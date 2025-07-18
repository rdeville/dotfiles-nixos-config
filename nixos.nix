{
  self,
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
        specialArgs = {
          inherit inputs lib self;
        };
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
          ({
            inputs,
            config,
            lib,
            ...
          }: let
            cfg = config.os;
          in {
            config = {
              os = {
                inherit (release) isProd;
              };

              home-manager = {
                useGlobalPkgs = false;
                useUserPackages = true;
                extraSpecialArgs = {
                  # Here the magic happens with inputs into home-manager
                  inherit inputs lib self;
                };
                users = builtins.foldl' (acc: user:
                  {
                    # Here is the magic to manage both HM/Nixos in a clean homogeneous way
                    "${user}" = {
                      imports =
                        if (builtins.pathExists ./machines/${cfg.hostName}/users/${user}/default.nix)
                        then [
                          ./home-manager/_modules.nix
                          ./machines/${cfg.hostName}/users/${user}
                        ]
                        else [
                          ./home-manager/_modules.nix
                        ];
                    };
                  }
                  // acc) {} (builtins.attrNames config.os.users.users);
              };
            };
          })
        ];
      };
    }
    // acc) {}
  lib.getValidHosts
