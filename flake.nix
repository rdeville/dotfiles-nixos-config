{
  # Inspiration sources : https://github.com/jonringer/nixpkgs-config.git
  description = "My NixOS and Home Manager configuration";

  inputs = {
    # Stable Nix Packages
    nixpkgs = {
      url = "nixpkgs/nixos-24.05";
    };
    # Flake Utils Lib
    utils = {
      url = "github:numtide/flake-utils";
    };

    # Devenv to automate development environment combined with direnv
    devenv = {
      url = "github:cachix/devenv";
    };
    # # Nix formatter
    alejandra = {
      url = "github:kamadorueda/alejandra/3.0.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # NixOS /HM Config
    nixos = {
      url = "/home/rdeville/git/framagit.org/public/dotfiles/nixos";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.utils.follows = "utils";
    };
    # My personal dotfiles flakes
    direnv = {
      url = "git+https://framagit.org/rdeville-public/dotfiles/direnv.git";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.utils.follows = "utils";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    utils,
    devenv,
    alejandra,
    nixos,
    direnv,
    ...
  }: let
    # All my hosts with users configs
    allConfigs = import ./configs {
      mkLib = nixos.homeManagerModules.accountLib;
      inherit direnv;
    };

    pkgsForSystem = system:
      import nixpkgs {
        inherit system;
      };

    # This is a function that generates an attribute by calling a function you
    # pass to it, with each system as an argument
    forAllSystems = nixpkgs.lib.genAttrs allSystems;

    hmLib = nixos.homeManagerModules.hmLib {inherit (nixos) inputs;};
    nixosLib = nixos.homeManagerModules.nixosLib {inherit (nixos) inputs;};
    mkLib = nixos.homeManagerModules.mkLib {inherit (nixos) inputs;};

    allSystems = [
      "x86_64-linux"
      "aarch64-linux"
      "x86_64-darwin"
      "aarch64-darwin"
    ];
  in
    utils.lib.eachSystem allSystems (
      system: let
        pkgs = pkgsForSystem system;
      in rec {
        packages = {
          devenv-up = self.devShells.${system}.default.config.procfileScript;
        };

        devShells = {
          default = devenv.lib.mkShell {
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
          alejandra.defaultPackage.${system}
      );

      # CONFIGURATION
      # ========================================================================
      # NIXOS
      # ------------------------------------------------------------------------
      # Bulid NixOS config from ./config.nix
      nixosConfigurations = builtins.mapAttrs (name: value:
        nixosLib.mkNixOS)
      allConfigs.hosts;

      # VMs I use to test NixOS configs
      # Build NixOS VMs using nixos-shell, see nixvm.sh to deploy
      nixos-shellConfigurations = builtins.mapAttrs (name: value:
        nixosLib.mkNixOS (nixosLib.mkNixVMs-nixos-shell value))
      allConfigs.vms;

      # Build NixOS VMs using microvm, see nixvm.sh to deploy
      microvmConfigurations = builtins.mapAttrs (name: value:
        nixosLib.mkNixOS (nixosLib.mkNixVMs-microvm value))
      allConfigs.vms;

      # HOME MANAGER
      # ------------------------------------------------------------------------
      # Build Home-Manager Config from ./config.nix
      homeConfigurations = builtins.mapAttrs (name: value:
        hmLib.mkHomeConfiguration value)
      (hmLib.mkHomeConfigs allConfigs);
    };
}
