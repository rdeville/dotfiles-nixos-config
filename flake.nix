# BEGIN DOTGIT-SYNC BLOCK MANAGED
{
  description = ''
    Flake for Nixos Config Data

    Repository storing configuration for my computer and users used with NixOS and
    Home-Manager
  '';
  # Devenv Cachix
  nixConfig = {
    extra-trusted-public-keys = "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=";
    extra-substituters = "https://devenv.cachix.org";
  };

  inputs = {
    # Stable Nix Packages
    nixpkgs = {
      url = "nixpkgs/nixos-24.05";
      # url = "github:nixos/nixpkgs/nixos-unstable";
    };
    # Flake Utils Lib
    utils = {
      url = "github:numtide/flake-utils";
    };
    # Devenv to automate development environment combined with direnv
    devenv = {
      url = "github:cachix/devenv";
    };
    alejandra = {
      url = "github:kamadorueda/alejandra/3.0.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # BEGIN DOTGIT-SYNC BLOCK EXCLUDED NIX_FLAKE_INPUT
    # Home Manager, manage your Home from nix
    home-manager = {
      inputs.nixpkgs.follows = "nixpkgs-unstable";
      url = "github:nix-community/home-manager";
    };
    # Unstable Nix Packages
    nixpkgs-unstable = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };
    # NixOS /HM Config
    nixos = {
      url = "git+https://framagit.org/rdeville-public/dotfiles/nixos-config.git";
      inputs = {
        nixpkgs.follows = "nixpkgs-unstable";
        utils.follows = "utils";
        home-manager.follows = "home-manager";
        nixpkgs-unstable.follows = "nixpkgs-unstable";
      };
    };
    # My personal dotfiles flakes
    awesomerc = {
      url = "git+https://framagit.org/rdeville-public/dotfiles/awesome.git";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.utils.follows = "utils";
    };
    direnvrc = {
      url = "git+https://framagit.org/rdeville-public/dotfiles/direnv.git";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.utils.follows = "utils";
    };
    neovimrc = {
      url = "git+https://framagit.org/rdeville-public/dotfiles/neovim.git";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.utils.follows = "utils";
    };
    tmuxrc = {
      url = "git+https://framagit.org/rdeville-public/dotfiles/tmux.git";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.utils.follows = "utils";
    };
    zshrc = {
      url = "git+https://framagit.org/rdeville-public/dotfiles/shell.git";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.utils.follows = "utils";
    };
    # My programs I want on my computer
    dotgit-sync = {
      url = "git+https://framagit.org/rdeville-public/programs/dotgit-sync.git";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.utils.follows = "utils";
    };
    # END DOTGIT-SYNC BLOCK EXCLUDED NIX_FLAKE_INPUT
  };

  outputs = inputs @ {self, ...}: let
    pkgsForSystem = system:
      import inputs.nixpkgs {
        inherit system;
      };

    # This is a function that generates an attribute by calling a function you
    # pass to it, with each system as an argument
    forAllSystems = inputs.nixpkgs.lib.genAttrs allSystems;

    allSystems = [
      "x86_64-linux"
      "aarch64-linux"
      "x86_64-darwin"
      "aarch64-darwin"
    ];
    # BEGIN DOTGIT-SYNC BLOCK EXCLUDED NIX_FLAKE_CUSTOM_VARS
    allConfigs = import ./configs {
      mkLib = inputs.nixos.homeManagerModules.accountLib;
      inherit inputs;
    };

    hmLib = inputs.nixos.homeManagerModules.hmLib {inherit (inputs.nixos) inputs;};
    nixosLib = inputs.nixos.homeManagerModules.nixosLib {inherit (inputs.nixos) inputs;};
    # mkLib = inputs.nixos.homeManagerModules.mkLib {inherit (inputs.nixos) inputs;};
    # END DOTGIT-SYNC BLOCK EXCLUDED NIX_FLAKE_CUSTOM_VARS

  in
    inputs.utils.lib.eachSystem allSystems (
      system: let
        pkgs = pkgsForSystem system;
      in rec {
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

      # BEGIN DOTGIT-SYNC BLOCK EXCLUDED NIX_FLAKE_OUTPUTS_CUSTOM
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
        nixosLib.mkNixOS (inputs.nixosLib.mkNixVMs-nixos-shell value))
      allConfigs.vms;

      # Build NixOS VMs using microvm, see nixvm.sh to deploy
      microvmConfigurations = builtins.mapAttrs (name: value:
        nixosLib.mkNixOS (inputs.nixosLib.mkNixVMs-microvm value))
      allConfigs.vms;

      # HOME MANAGER
      # ------------------------------------------------------------------------
      # Build Home-Manager Config from ./config.nix
      homeConfigurations = builtins.mapAttrs (name: value:
        hmLib.mkHomeConfiguration value)
      (hmLib.mkHomeConfigs allConfigs);
      # END DOTGIT-SYNC BLOCK EXCLUDED NIX_FLAKE_OUTPUTS_CUSTOM
  };
}
# END DOTGIT-SYNC BLOCK MANAGED
