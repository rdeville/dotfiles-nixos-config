{
  osConfig ? {},
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.hm;
in {
  imports = [
    ./flavors
    ../modules
  ];

  options = {
    hm = lib.mkOption {
      description = ''
        My custom `hm` module to setup Nix Home-Manager using my own flavors
      '';
      default = {};
      type = lib.types.submodule {
        options = {
          hostName = lib.mkOption {
            type = lib.types.str;
            description = "Hostname where config will be applied.";
            default =
              if osConfig ? networking
              then osConfig.networking.hostName
              else "";
          };

          stateVersion = lib.mkOption {
            type = lib.types.str;
            description = "Version of HM to follow";
            default = "25.05";
          };

          system = lib.mkOption {
            type = lib.types.str;
            description = "Arch system where config will be applied.";
            default =
              if osConfig ? nixpkgs.hostPlatform
              then osConfig.nixpkgs.hostPlatform
              else "";
          };

          username = lib.mkOption {
            type = lib.types.str;
            description = "Username to apply.";
          };

          homeDirectory = lib.mkOption {
            type = lib.types.str;
            description = "Path to the home directory.";
            default =
              if cfg.isDarwin
              then "/Users/${cfg.username}"
              else if cfg.username != "root"
              then "/home/${cfg.username}"
              else "/${cfg.username}";
          };

          wrapGL = lib.mkOption {
            type = lib.types.bool;
            description = "Boolean, set to true to specify OS is darwin.";
            default = false;
          };

          isDarwin = lib.mkOption {
            type = lib.types.bool;
            description = "Boolean, set to true to specify OS is darwin.";
            default = false;
          };

          isWork = lib.mkOption {
            type = lib.types.bool;
            description = "Boolean, set to true to host is my professional computer.";
            default = false;
          };

          sessionPath = lib.mkOption {
            type = lib.types.listOf lib.types.str;
            description = "Set user session path";
            default = [
              "$HOME/.local/share/bin"
              "$HOME/.local/bin"
            ];
          };

          sessionVariables = lib.mkOption {
            type = lib.types.attrsOf lib.types.str;
            description = "Set user session variables.";
            default = {
              HOST = cfg.hostName;
              EDITOR = "nvim";
            };
          };

          nixpkgs = {
            allowUnfree = lib.mkOption {
              type = lib.types.bool;
              description = "If true, allow installation of unfree packages.";
              default = false;
            };
          };
        };
      };
    };
  };

  config = {
    home = {
      inherit
        (cfg)
        stateVersion
        username
        sessionPath
        sessionVariables
        ;

      # Required to force to avoid conflict with
      # (modulesPath + "/installer/cd-dvd/installation-cd-minimal.nix")
      homeDirectory = lib.mkForce cfg.homeDirectory;
      preferXdgDirectories = true;
    };

    nixpkgs = {
      config = {
        inherit (cfg.nixpkgs) allowUnfree;
      };
    };

    nix = {
      gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 7d";
      };

      package = lib.mkDefault pkgs.nixVersions.latest;

      settings = {
        accept-flake-config = true;
        auto-optimise-store = true;
        extra-experimental-features = [
          "flakes"
          "nix-command"
          "auto-allocate-uids"
        ];
        keep-outputs = true;
        keep-derivations = true;
        show-trace = true;
        trusted-users = [
          "root"
          "@wheel"
          "@sudo"
        ];
      };
    };

    systemd = {
      user = {
        startServices = "sd-switch";
      };
    };
  };
}
