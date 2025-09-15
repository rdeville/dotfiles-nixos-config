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
    nixpkgs-stable = {
      url = "github:nixos/nixpkgs/nixos-25.05";
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
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };
    nixos-facter-modules = {
      url = "github:numtide/nixos-facter-modules";
    };
    # Packages or tools inputs
    nix-topology = {
      url = "github:oddlama/nix-topology";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };
    microvm = {
      url = "github:astro/microvm.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    microvm-stable = {
      url = "github:astro/microvm.nix";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };

    # Non flake repo, since I use specific files from them
    ls-colors = {
      url = "github:trapd00r/LS_COLORS";
      flake = false;
    };
    ai-robot-txt = {
      url = "github:ai-robots-txt/ai.robots.txt";
      flake = false;
    };
    # My Personal Public NixOS /HM Config
    # -------------------------------------------------------------------------
    nixos = {
      url = "git+https://framagit.org/rdeville-public/dotfiles/nixos-config.git";
      inputs = {
        awesome.follows = "awesome";
        home-manager.follows = "home-manager";
        nixgl.follows = "nixgl";
        nixpkgs.follows = "nixpkgs";
        nix-index-database.follows = "nix-index-database";
        sops-nix.follows = "sops-nix";
        ls-colors.follows = "ls-colors";
      };
    };
    nixos-stable = {
      url = "git+https://framagit.org/rdeville-public/dotfiles/nixos-config.git";
      inputs = {
        awesome.follows = "awesome";
        home-manager.follows = "home-manager";
        nixgl.follows = "nixgl";
        nixpkgs.follows = "nixpkgs-stable";
        nix-index-database.follows = "nix-index-database";
        sops-nix.follows = "sops-nix";
        ls-colors.follows = "ls-colors";
      };
    };
    awesome = {
      url = "github:awesomeWM/awesome/master";
      flake = false;
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
      url = "git+https://framagit.org/rdeville-public/dotfiles/tmux";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };
    tmuxdata = {
      url = "git+ssh://git@framagit.org:/rdeville-private/dotfiles/tmux";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };
    # Overlays
    # -------------------------------------------------------------------------
    # Overlays are dynamically managed based on input name.
    # cf: https://github.com/NixOS/nixpkgs/pull/XXXXXXXX
    # overlay-PKG_NAME-YYYY-MM-DD = {
    #   url = "github:nixos/nixpkgs/abcdef01234567890abcdefg01234567890abcdef";
    # };
    # Wait for this PR to be backported to unstable:
    # https://github.com/NixOS/nixpkgs/pull/437045
    overlay-vdirsyncer-2025-08-28 = {
      url = "github:nixos/nixpkgs/85dbfc7aaf52ecb755f87e577ddbe6dbbdbc1054";
    };
    overlay-spotify-player-2025-09-03 = {
      url = "github:nixos/nixpkgs/a19e4649f8542b591750b79e59288c1cd5ebeefd";
    };
    overlay-nwg-displays-2025-09-03 = {
      url = "github:nixos/nixpkgs/a3887e95aa55d8738445133f896ad4b75b54b9d0";
    };
    overlay-terraform-docs-2025-09-13 = {
      url = "github:nixos/nixpkgs/d0fc30899600b9b3466ddb260fd83deb486c32f1";
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
          import ./lib/default.nix self final
        )
      );

    pkgsForSystem = system:
      import inputs.nixpkgs {
        inherit system;
        overlays = [
          inputs.nixgl.overlay
          inputs.nix-topology.overlays.default
        ];
      };
  in {
    # TOOLING
    # ------------------------------------------------------------------------
    # Formatter for your nix files, available through 'nix fmt'
    # Other options beside 'alejandra' include 'nixpkgs-fmt'
    formatter = forAllSystems (
      system: let
        pkgs = pkgsForSystem system;
      in
        pkgs.alejandra
    );

    # PACKAGES
    # ------------------------------------------------------------------------
    packages = forAllSystems (
      system: let
        pkgs = pkgsForSystem system;
      in {
        default = import ./scripts {inherit pkgs;};
        scripts = import ./scripts {inherit pkgs;};
      }
    );

    # NIXOS
    # ------------------------------------------------------------------------
    nixosConfigurations = import ./nixos.nix {inherit inputs lib self;};

    # HOME MANAGER
    # ------------------------------------------------------------------------
    homeConfigurations = import ./home-manager.nix {inherit inputs lib;};

    # TOPOLOGY
    # ------------------------------------------------------------------------
    topology = forAllSystems (
      system: let
        pkgs = pkgsForSystem system;
      in
        import inputs.nix-topology {
          inherit pkgs;
          modules = [
            # Your own file to define global topology.
            # Works in principle like a nixos module but uses different options.
            ./topology.nix
            # Inline module to inform topology of your existing NixOS hosts.
            {
              nixosConfigurations = builtins.foldl' (acc: elem:
                {
                  ${elem} = self.nixosConfigurations.${elem};
                }
                // acc) {} (builtins.filter (host:
                builtins.match "nixos-live.*" host != [])
              (builtins.attrNames self.nixosConfigurations));
            }
          ];
        }
    );
  };
}
