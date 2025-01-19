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
    nixos-shell = {
      url = "github:Mic92/nixos-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    microvm = {
      url = "github:astro/microvm.nix";
      inputs.nixpkgs.follows = "nixpkgs";
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
    # hyprland = {
    #   url = "github:hyprwm/Hyprland";
    # };
    # hyprland-plugins = {
    #   url = "github:hyprwm/hyprland-plugins";
    #   inputs.hyprland.follows = "hyprland";
    # };
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
    colmena = {
      url = "github:zhaofengli/colmena";
      inputs.nixpkgs.follows = "nixpkgs";
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
        lib = mkLib inputs.nixpkgs "home-manager";
      };
      homeManagerModule = self.homeManagerModules.hm;

      nixosModules = {
        os = import ./nixos;
        lib = mkLib inputs.nixpkgs "nixos";
      };
      nixosModule = self.nixosModules.os;
    };
}
