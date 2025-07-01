{
  config,
  lib,
  pkgs,
  ...
}: let
  name = builtins.baseNameOf ./.;
  cfg = config.os.flavors.${name};
in {
  options = {
    os = {
      flavors = {
        ${name} = {
          enable = lib.mkDefaultEnabledOption "Install ${name} NixOS flavors.";

          nix-ld = {
            enable = lib.mkDefaultEnabledOption ''
              Install nix-ld to use \"dynamic shared library\"
            '';
          };
        };
      };
    };
  };

  config = lib.mkIf cfg.enable {
    documentation = {
      nixos = {
        includeAllModules = true;
      };
    };

    fonts = {
      packages = with pkgs; [
        # NixOS
        carlito
        vegur
        source-code-pro
        jetbrains-mono
        noto-fonts-color-emoji
        # Icons
        font-awesome
        # Nerdfont Icons
        nerd-fonts.fira-code
      ];
    };

    environment = {
      variables = {
        EDITOR = "nvim";
        VISUAL = "nvim";
      };

      # System-Wide Packages
      systemPackages = with pkgs; [
        # Terminal
        btop # Resource Manager
        htop # Process Manager
        coreutils # GNU Utilities
        killall # Process Killer
        lshw # Hardware Config
        pciutils # Manage PCI
        usbutils # Manage USB

        # NixOS CLI related packages
        nix-tree # Browse Nix Store
        nh # Wrapper above nixos-rebuild or home-manager
        home-manager # Home manager
      ];
    };

    programs = {
      # Allow to use .pre-commit
      inherit (cfg) nix-ld;
    };
  };
}
