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
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };
    utils = {
      url = "github:numtide/flake-utils";
    };
    devenv = {
      url = "github:cachix/devenv";
    };
    alejandra = {
      url = "github:kamadorueda/alejandra";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # BEGIN DOTGIT-SYNC BLOCK EXCLUDED NIX_FLAKE_INPUT
    sops-nix = {
      url = "github:Mic92/sops-nix/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # My Personal Public NixOS /HM Config
    nixos = {
      url = "git+https://framagit.org/rdeville-public/dotfiles/nixos-config.git";
      inputs = {
        alejandra.follows = "alejandra";
        awesome.follows = "awesome";
        home-manager.follows = "home-manager";
        nixpkgs.follows = "nixpkgs";
        sops-nix.follows = "sops-nix";
        utils.follows = "utils";
      };
    };
    awesome = {
      url = "github:awesomeWM/awesome";
      flake = false;
    };

    # My personal dotfiles flakes
    awesomerc = {
      url = "git+https://framagit.org/rdeville-public/dotfiles/awesomewm.git";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        utils.follows = "utils";
        alejandra.follows = "alejandra";
      };
    };
    direnvrc = {
      url = "git+https://framagit.org/rdeville-public/dotfiles/direnv.git";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        utils.follows = "utils";
        alejandra.follows = "alejandra";
      };
    };
    neovimrc = {
      url = "git+https://framagit.org/rdeville-public/dotfiles/neovim.git";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        utils.follows = "utils";
        alejandra.follows = "alejandra";
      };
    };
    tmuxrc = {
      url = "git+https://framagit.org/rdeville-public/dotfiles/tmux.git";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        utils.follows = "utils";
        alejandra.follows = "alejandra";
      };
    };
    zshrc = {
      url = "git+https://framagit.org/rdeville-public/dotfiles/shell.git";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        utils.follows = "utils";
        alejandra.follows = "alejandra";
      };
    };
    # My programs I want on my computer
    dotgit-sync = {
      url = "git+https://framagit.org/rdeville-public/programs/dotgit-sync.git";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        utils.follows = "utils";
        alejandra.follows = "alejandra";
      };
    };
    # END DOTGIT-SYNC BLOCK EXCLUDED NIX_FLAKE_INPUT
  };
  outputs = inputs @ {self, ...}: let
    # BEGIN DOTGIT-SYNC BLOCK EXCLUDED NIX_FLAKE_CUSTOM_VARS
    # This is a function that generates an attribute by calling a function you
    # pass to it, with each system as an argument
    forAllSystems = inputs.nixpkgs.lib.genAttrs allSystems;

    allSystems = [
      "x86_64-linux"
      "aarch64-linux"
      "x86_64-darwin"
      "aarch64-darwin"
    ];
    # END DOTGIT-SYNC BLOCK EXCLUDED NIX_FLAKE_CUSTOM_VARS
  in
    inputs.utils.lib.eachSystem allSystems (
      system: let
        pkgs = inputs.nixos.homeManagerModules.lib.pkgsForSystem system;
      in {
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
      nixosConfigurations = let
        lib =
          inputs.nixos.homeManagerModules.lib.extend
          (
            final: prev: (
              import ./lib/default.nix final
            )
          );
      in
        builtins.foldl' (acc: elem:
          {
            "${elem}" = inputs.nixpkgs.lib.nixosSystem {
              modules = [
                ./nixos
                ./configs/hosts/${elem}/configuration.nix
                ./configs/hosts/${elem}/hardware-configuration.nix
                inputs.nixos.nixosModules.os
                inputs.home-manager.nixosModules.home-manager
                {
                  home-manager = {
                    useGlobalPkgs = true;
                    useUserPackages = true;
                    # users = {
                    #   ${username} = {...}:{
                    #     imports = [
                    #       ./home-manager
                    #     ];
                    #   };
                    # };
                  };
                }
              ];
              specialArgs = let
                config = import ./configs/hosts/${elem} {};
              in {
                inherit inputs;
                inherit (inputs.nixos.homeManagerModules) lib;
                inherit (config) os;
              };
            };
          }
          // acc) {} (lib.listDirs ./configs/hosts);

      # HOME MANAGER
      # ------------------------------------------------------------------------
      homeConfigurations = let
        lib =
          inputs.nixos.homeManagerModules.lib.extend
          (
            final: prev: (
              import ./lib/default.nix final
            )
          );
      in
        builtins.listToAttrs (
          builtins.concatLists (builtins.map (
            host: let
              pkgs =
                inputs.nixos.homeManagerModules.lib.pkgsForSystem
                (
                  import ./configs/hosts/${host} {}
                )
                .os
                .system;
            in
              builtins.map (
                user: {
                  name = "${user}@${host}";
                  value = inputs.home-manager.lib.homeManagerConfiguration {
                    inherit pkgs;
                    modules = [
                      # External Modules
                      inputs.nixos.inputs.sops-nix.homeManagerModules.sops
                      # Internal Modules
                      inputs.nixos.homeManagerModules.hm
                      # Personnal home-manager packaged dotfiles
                      inputs.awesomerc.homeManagerModules.awesomerc
                      inputs.direnvrc.homeManagerModules.direnvrc
                      inputs.neovimrc.homeManagerModules.neovimrc
                      inputs.tmuxrc.homeManagerModules.tmuxrc
                      inputs.zshrc.homeManagerModules.shellrc
                      # Personnal packaged programs
                      inputs.dotgit-sync.homeManagerModules.dotgit-sync
                      # Local Modules
                      ./home-manager
                      # Hack to inject config
                      ({extraConfig, ...}: {
                        config = extraConfig;
                      })
                    ];
                    extraSpecialArgs = let
                      cfg = import ./configs/hosts/${host}/rdeville {
                        inherit lib pkgs;
                      };
                    in {
                      inherit inputs lib;
                      inherit (cfg) hm extraConfig;
                    };
                  };
                }
              )
              (lib.listDirs ./configs/hosts/${host})
          ) (lib.listDirs ./configs/hosts))
        );

      # END DOTGIT-SYNC BLOCK EXCLUDED NIX_FLAKE_OUTPUTS_CUSTOM
    };
}
# END DOTGIT-SYNC BLOCK MANAGED
