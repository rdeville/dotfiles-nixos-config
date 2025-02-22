{
  config,
  lib,
  pkgs,
  ...
}: let
  name = builtins.baseNameOf ./.;
  cfg = config.hm.flavors.${name};

  linuxPkgs = with pkgs; [
    lshw # Hardware Config
    usbutils # Manage USB
  ];
  darwinPkgs = [];
in {
  imports = builtins.map (item: ./${item}) (lib.importDir ./.);

  options = {
    hm = {
      flavors = {
        ${name} = {
          enable = lib.mkDefaultEnabledOption "Install ${name} Home-Manager flavor.";
        };
      };
    };
  };

  config = lib.mkIf cfg.enable {
    home = {
      packages = with pkgs;
        [
          age # Encryption tools
          alejandra # Nix Formatter
          bash # Shell Emulator
          bmon # Process and Resource Manager
          btop # Resource Manager
          colordiff # Better diff output
          coreutils # GNU Utilities
          curl # Retriever
          dbus
          devbox # Isolated development tools
          devenv # Isolated nix development tools
          diffutils # Command showing diff
          fzf # Fuzzy Finder
          gcc # C++ compiler
          git # Version Control
          htop # Process Manager
          jq # json manipulation tool
          killall # Process Killer
          neovim # Text Editor
          pciutils # Manage PCI
          p7zip # Zip Encryption
          smartmontools # Disk Health
          sops # Encryption tools
          ripgrep # Perl Grep
          rsync # Syncer - $ rsync -r dir1/ dir2/
          tig # Text Interface Git
          tree # Show folder as tree
          unzip # Zip Files
          xclip # Copy to clipboard
          xdg-utils # Environment integration
          viddy # A better watcher
          zip # Zip

          # NixOS CLI related packages
          nix-tree # Browse Nix Store
          nvd # Diff build for flakes/nix
          colmena # Stateless NixOS deployment tool
        ]
        ++ (
          if config.hm.isDarwin
          then darwinPkgs
          else linuxPkgs
        );
    };

    programs = {
      atuin = {
        enable = true;
        settings = {
          invert = false;
          keymap_mode = "vim-insert";
          enter_accept = true;
        };
        # flags = [
        #   "--disable-up-arrow"
        # ];
      };

      bat = {
        enable = true;
        config = {
          map-syntax = [];
          pager = "less -FR";
          theme = "TwoDark";
        };
      };

      dircolors = {
        enable = true;
        extraConfig = builtins.readFile (
          builtins.fetchurl {
            url = "https://raw.githubusercontent.com/trapd00r/LS_COLORS/master/LS_COLORS";
            sha256 = "1a4x93cmn4g4yzjvl5scah9pmzbqk1m71gfdnpbc6p2csg8yy8fi";
          }
        );
      };

      lsd = {
        enable = true;
      };

      nh = {
        enable = true;
        clean = {
          enable = false;
          dates = "weekly";
          extraArgs = builtins.concatStringsSep " " [
            "--keep 5"
            "--keep-since 3d"
          ];
        };
      };

      nix-index-database = {
        comma = {
          enable = true;
        };
      };

      nix-index = {
        enable = true;
      };

      thefuck = {
        enable = true;
      };

      zoxide = {
        enable = true;
      };
    };
  };
}
