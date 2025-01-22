{
  # Inspiration sources : https://github.com/jonringer/nixpkgs-config.git
  description = "My NixOS and Home Manager configuration";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    nixpkgs-unstable = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };
    nixos-hardware = {
      url = "github:nixos/nixos-hardware/master";
    };
    utils = {
      url = "github:numtide/flake-utils";
    };
    nixgl = {
      url = "github:nix-community/nixGL";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    devenv = {
      url = "github:cachix/devenv";
    };
    alejandra = {
      url = "github:kamadorueda/alejandra/3.0.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    awesome = {
      url = "github:awesomeWM/awesome/master";
      flake = false;
    };
    hyprswitch = {
      url = "github:h3rmt/hyprswitch/release";
    };
    warpd = {
      url = "github:rvaiya/warpd";
      flake = false;
    };
    rofi-themes = {
      url = "github:adi1090x/rofi";
      flake = false;
    };
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {self, ...}: let
    mkLib = nixpkgs: context:
      nixpkgs.lib.extend
      (final: prev:
        (
          import ./lib/default.nix inputs final
        )
        // (
          if inputs ? ${context}.lib
          then inputs.${context}.lib
          else {}
        ));

    # This is a function that generates an attribute by calling a function you
    # pass to it, with each system as an argument
    forAllSystems = inputs.nixpkgs.lib.genAttrs allSystems;

    allSystems = [
      "x86_64-linux"
      "aarch64-linux"
      "x86_64-darwin"
      "aarch64-darwin"
    ];

    # Function to manage Home Manager modules list for nixosConfigurations and
    # homeManageConfigurations both at once
    hmModules = user: [
      # Local Modules
      ./machines/dev/${user}
      ./home-manager
      # External Modules
      inputs.sops-nix.homeManagerModules.sops
      inputs.nix-index-database.hmModules.nix-index
    ];
  in
    inputs.utils.lib.eachSystem allSystems (
      system: let
        pkgs = mkLib inputs.nixpkgs system;
      in {
        legacyPackages = pkgs;

        packages = {
          devenv-up = self.devShells.${system}.default.config.procfileScript;
        };

        devShells = {
          default = inputs.devenv.lib.mkShell {
            inherit inputs pkgs;
            modules = [
              ./devenv.nix
            ];
          };
        };
      }
    )
    // {
      # TOOLING
      # ========================================================================
      # Formatter for your nix files, available through 'nix fmt'
      # Other options beside 'alejandra' include 'nixpkgs-fmt'
      formatter = forAllSystems (
        system:
          inputs.alejandra.defaultPackage.${system}
      );

      homeManagerModules = {
        hm = import ./home-manager;
        lib = mkLib inputs.nixpkgs "home-manager";
      };
      homeManagerModule = self.homeManagerModules.hm;

      nixosModules = {
        os = import ./nixos;
        lib = mkLib inputs.nixpkgs "nixos";
      };
      nixosModule = self.nixosModules.os;

      # NixOS Configurations
      # ------------------------------------------------------------------------
      nixosConfigurations = let
        lib = mkLib inputs.nixpkgs "nixos";
      in {
        # Developpement machine configuration to test public build and show an
        # example of configuration
        dev = inputs.nixpkgs.lib.nixosSystem {
          modules = [
            # Machine configuration.nix using my `os` and `hm` modules and
            # setting up some machine specific configurations (such as
            # hardware-config)
            ./machines/dev
            # External Modules
            inputs.sops-nix.nixosModules.sops
            inputs.home-manager.nixosModules.home-manager
            # Internal Modules
            self.nixosModules.os

            ({
              inputs,
              config,
              lib,
              ...
            }: {
              config = {
                home-manager = {
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  extraSpecialArgs = {
                    # Here the magic happens with inputs into home-manager
                    inherit inputs;
                  };
                  # Auto configure HM users in NixOS using directory structure :
                  # `machines/<hostName>/<userName>`
                  users = builtins.foldl' (acc: user:
                    {
                      # Here is the magic to manage both HM/Nixos in a clean
                      # homogeneous way
                      "${user}" = {...}: {
                        imports = hmModules user;
                      };
                    }
                    // acc) {} (lib.listDirs ./machines/dev);
                };
              };
            })
          ];
          specialArgs = {
            inherit inputs lib;
          };
        };
      };
      # Home Manager Configurations
      # ------------------------------------------------------------------------
      homeConfigurations = let
        lib = mkLib inputs.nixpkgs "home-manager";
      in
        # Auto configure HM users using directory structure :
        # `machines/<hostName>/<userName>`
        builtins.foldl' (acc: user:
          {
            "${user}@dev" = let
              system = (import ./machines/dev/base.nix).system;
            in
              inputs.home-manager.lib.homeManagerConfiguration {
                # inherit pkgs;
                pkgs = lib.pkgsForSystem system;
                # Here is the magic to manage both HM/Nixos in a clean
                # homogeneous way
                modules = hmModules user;
                extraSpecialArgs = {
                  inherit inputs lib;
                };
              };
          }
          // acc) {} (lib.listDirs ./machines/dev);
    };
}
