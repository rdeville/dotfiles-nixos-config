{
  description = ''
    Flake for Nixos Config Data

    Repository storing configuration for my computer and users used with NixOS and
    Home-Manager
  '';

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix/master";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };
    nixgl = {
      url = "github:nix-community/nixGL";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-facter-modules = {
      url = "github:numtide/nixos-facter-modules";
    };
    # My Personal Public NixOS /HM Config
    nixos = {
      url = "git+https://framagit.org/rdeville-public/dotfiles/nixos-config.git";
      inputs = {
        awesome.follows = "awesome";
        home-manager.follows = "home-manager";
        hyprswitch.follows = "hyprswitch";
        nixgl.follows = "nixgl";
        nixpkgs.follows = "nixpkgs";
        nix-index-database.follows = "nix-index-database";
        sops-nix.follows = "sops-nix";
      };
    };
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };
    awesome = {
      url = "github:awesomeWM/awesome/master";
      flake = false;
    };
    hyprswitch = {
      url = "github:h3rmt/hyprswitch/release";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };
    # My personal dotfiles flakes
    awesomerc = {
      url = "git+https://framagit.org/rdeville-public/dotfiles/awesomewm.git";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        awesome.follows = "awesome";
      };
    };
    direnvrc = {
      url = "git+https://framagit.org/rdeville-public/dotfiles/direnv.git";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };
    neovimrc = {
      url = "git+https://framagit.org/rdeville-public/dotfiles/neovim.git";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };
    tmuxrc = {
      url = "git+https://framagit.org/rdeville-public/dotfiles/tmux.git";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };
    zshrc = {
      url = "git+https://framagit.org/rdeville-public/dotfiles/shell.git";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };
    # My programs I want on my computer
    dotgit-sync = {
      url = "git+https://framagit.org/rdeville-public/programs/dotgit-sync.git";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };
  };
  outputs = inputs @ {self, ...}: let
    # This is a function that generates an attribute by calling a function you
    # pass to it, with each system as an argument
    forAllSystems = inputs.nixpkgs.lib.genAttrs allSystems;

    allSystems = [
      "x86_64-linux"
      "aarch64-linux"
      "x86_64-darwin"
      "aarch64-darwin"
    ];

    lib =
      inputs.nixos.homeManagerModules.lib.extend
      (
        final: prev: (
          import ./lib/default.nix final
        )
      );
  in {
    # TOOLING
    # ========================================================================
    # Formatter for your nix files, available through 'nix fmt'
    # Other options beside 'alejandra' include 'nixpkgs-fmt'
    formatter = forAllSystems (
      system: let
        pkgs = inputs.nixos.nixosModules.lib.pkgsForSystem system;
      in
        pkgs.alejandra
    );

    # PACKAGES
    # ========================================================================
    packages = forAllSystems (
      system: let
        pkgs = inputs.nixos.nixosModules.lib.pkgsForSystem system;
      in {
        default = import ./scripts {inherit pkgs;};
        scripts = import ./scripts {inherit pkgs;};
      }
    );

    # NIXOS
    # ------------------------------------------------------------------------
    nixosConfigurations = import ./nixos.nix {inherit inputs lib;};

    # HOME MANAGER
    # ------------------------------------------------------------------------
    homeConfigurations = import ./home-manager.nix {inherit inputs lib;};
  };
}
