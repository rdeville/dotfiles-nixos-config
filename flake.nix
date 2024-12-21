{
  # Inspiration sources : https://github.com/jonringer/nixpkgs-config.git
  description = "My NixOS and Home Manager configuration";

  inputs = {
    # Stable Nix Packages
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };
    # Home Manager, manage your Home from nix
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    # Unstable Nix Packages
    nixpkgs-unstable = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };
    # Hardware Specific configuration
    nixos-hardware = {
      url = "github:nixos/nixos-hardware/master";
    };
    # NixOS Small VM with nixos-shell
    nixos-shell = {
      url = "github:Mic92/nixos-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # NixOS MicroVMs
    microvm = {
      url = "github:astro/microvm.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Flake Utils Lib
    utils = {
      url = "github:numtide/flake-utils";
    };
    # OpenGL Wrapper
    nixgl = {
      url = "github:nix-community/nixGL";
    };
    # Nix secret managed using sops
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Devenv to automate development environment combined with direnv
    devenv = {
      url = "github:cachix/devenv";
    };
    # Nix formatter
    alejandra = {
      url = "github:kamadorueda/alejandra/3.0.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    awesome = {
      url = "github:awesomeWM/awesome/master";
      flake = false;
    };
  };

  nixConfig = {
    extra-trusted-public-keys = "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=";
    extra-substituters = "https://devenv.cachix.org";
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

    pkgsForSystem = system:
      import inputs.nixpkgs {
        inherit system;
        overlays = [inputs.nixgl.overlay];
        config = {
          allowUnfree = true;
        };
      };


    allSystems = [
      "x86_64-linux"
      "aarch64-linux"
      "x86_64-darwin"
      "aarch64-darwin"
    ];
  in
    inputs.utils.lib.eachSystem allSystems (
      system: let
        pkgs = mkLib.pkgsForSystem system;
      in {
        legacyPackages = mkLib.pkgsForSystem system;

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
      };
      homeManagerModule = self.homeManagerModules.hm;

      nixosModules = {
        os = import ./nixos;
      };
      nixosModule = self.nixosModules.os;
    };
}
