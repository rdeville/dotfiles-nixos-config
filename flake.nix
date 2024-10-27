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
      # url = "github:nixos/nixpkgs/nixos-24.05";
      url = "github:nixos/nixpkgs/nixos-unstable";
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
      url = "github:kamadorueda/alejandra";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # BEGIN DOTGIT-SYNC BLOCK EXCLUDED NIX_FLAKE_INPUT
    # Nix secret managed using sops
    sops-nix = {
      url = "github:Mic92/sops-nix/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Home Manager, manage your Home from nix
    home-manager = {
      # url = "github:nix-community/home-manager/release-24.05";
      url = "github:nix-community/home-manager";
      # inputs.nixpkgs.follows = "nixpkgs-unstable";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Unstable Nix Packages
    # nixpkgs-unstable = {
    #   url = "github:nixos/nixpkgs/nixos-unstable";
    # };
    # NixOS /HM Config
    nixos = {
      url = "git+https://framagit.org/rdeville-public/dotfiles/nixos-config.git";
      # url = "/home/rdeville/git/framagit.org/public/dotfiles/nixos/";
      inputs = {
        alejandra.follows = "alejandra";
        awesome.follows = "awesome";
        home-manager.follows = "home-manager";
        nixpkgs.follows = "nixpkgs";
        # nixpkgs-unstable.follows = "nixpkgs";
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
      url = "git+https://framagit.org/rdeville-public/dotfiles/awesome.git";
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
    pkgsForSystem = system:
      import inputs.nixpkgs {
        inherit system;
      };
    # BEGIN DOTGIT-SYNC BLOCK EXCLUDED NIX_FLAKE_CUSTOM_VARS
    #
    # Some libs
    mkLib = inputs.nixos.homeManagerModules.mkLib {inherit (inputs.nixos) inputs;};
    accountsLib = inputs.nixos.homeManagerModules.accountsLib;
    hmLib = inputs.nixos.homeManagerModules.hmLib {inherit (inputs.nixos) inputs;};

    # This is a function that generates an attribute by calling a function you
    # pass to it, with each system as an argument
    forAllSystems = inputs.nixpkgs.lib.genAttrs allSystems;

    mkHostConfig = hostname:
      import ./configs/hosts/${hostname} {
        inherit inputs mkLib hmLib accountsLib hostname;
      };

    hmConfig = builtins.listToAttrs (builtins.concatLists (builtins.map (
      host: let
        hostCfg = mkHostConfig host;
      in
        builtins.map (
          user: {
            name = "${user}@${host}";
            value = {
              pkgs = pkgsForSystem hostCfg.system;
              modules = [
                # External Modules
                inputs.nixos.inputs.sops-nix.homeManagerModules.sops
                # Internal Modules
                inputs.nixos.homeManagerModules.presets
                inputs.nixos.homeManagerModules.flavors
                # Personnal home-manager packaged dotfiles
                inputs.awesomerc.homeManagerModules.awesomerc
                inputs.direnvrc.homeManagerModules.direnvrc
                inputs.neovimrc.homeManagerModules.neovimrc
                inputs.tmuxrc.homeManagerModules.tmuxrc
                inputs.zshrc.homeManagerModules.shellrc
                # Personnal packaged programs
                inputs.dotgit-sync.homeManagerModules.dotgit-sync
                # Local Modules
                ./home-manager/flavors
                ./home-manager/presets
                ./modules/home-manager.nix
              ];
              extraSpecialArgs = {
                userCfg = hostCfg.users.${user};
                inherit mkLib;
              };
            };
          }
        )
        (mkLib.mkListDirs ./configs/hosts/${host})
    ) (mkLib.mkListDirs ./configs/hosts)));

    nixosConfig = builtins.foldl' (acc: elem:
      {
        "${elem}" = {
          specialArgs = {
            hostCfg = mkHostConfig elem;
            inherit inputs;
          };
          modules = [
            ./configs/hosts/${elem}/configuration.nix
            ./configs/hosts/${elem}/hardware-configuration.nix
            inputs.nixos.nixosModules.presets
            inputs.nixos.nixosModules.flavors
            inputs.home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                # users = hmModule (mkHostConfig elem);
              };
            }
          ];
        };
      }
      // acc) {} (mkLib.mkListDirs ./configs/hosts);

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
        pkgs = pkgsForSystem system;
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
      nixosConfigurations =
        builtins.mapAttrs (
          _: value:
            inputs.nixpkgs.lib.nixosSystem value
        )
        nixosConfig;

      # HOME MANAGER
      # ------------------------------------------------------------------------
      homeConfigurations =
        builtins.mapAttrs (
          _: value:
            inputs.home-manager.lib.homeManagerConfiguration value
        )
        hmConfig;
      # END DOTGIT-SYNC BLOCK EXCLUDED NIX_FLAKE_OUTPUTS_CUSTOM
    };
}
# END DOTGIT-SYNC BLOCK MANAGED
