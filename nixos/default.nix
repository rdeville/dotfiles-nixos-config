{
  config,
  lib,
  os,
  ...
}: let
  cfg = config.os;
in {
  imports = builtins.map (item: ./${item}) (lib.importDir ./.);

  options = {
    os = {
      stateVersion = lib.mkOption {
        type = lib.types.str;
        description = "Version of HM to follow";
        default = "24.11";
      };

      system = lib.mkOption {
        type = lib.types.str;
        description = "Arch system where config will be applied.";
        default = "x86-64_linux";
      };

      hostname = lib.mkOption {
        type = lib.types.str;
        description = "Hostname where config will be applied.";
      };

      allowUnfree = lib.mkOption {
        type = lib.types.bool;
        description = "If true, allow installation of unfree packages.";
        default = false;
      };

      keyMap = lib.mkOption {
        type = lib.types.either lib.types.str lib.types.path;
        description = "The keyboard mapping table for the virtual consoles.";
        default = "fr";
      };

      isGui = lib.mkOption {
        type = lib.types.bool;
        description = "If true, setup GUI environnement.";
        default = false;
      };

      isMain = lib.mkOption {
        type = lib.types.bool;
        description = "If true, setup Main environnement.";
        default = false;
      };
    };
  };

  config = {
    inherit os;

    # For more information, see `man configuration.nix` or
    # https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
    system = {
      stateVersion = config.os.stateVersion;
    };

    nixpkgs = {
      config = {
        allowUnfree = cfg.allowUnfree;
      };
    };

    documentation = {
      nixos = {
        includeAllModules = true;
      };
    };

    networking = {
      hostName = cfg.hostname;
    };

    console = {
      font = "Lat2-Terminus16";
      keyMap = cfg.keyMap;
    };

    services = {
      xserver = lib.mkIf cfg.isGui {
        # Enable the X11 windowing system.
        enable = true;
        # Configure keymap in X11
        xkb = {
          layout = cfg.keyMap;
          options = "caps:escape";
        };
      };
    };

    # Locale configuration
    i18n = {
      defaultLocale = "en_US.UTF-8";
      extraLocaleSettings = {
        LC_MONETARY = "fr_FR.UTF-8";
      };
    };

    # Timezone
    time = {
      timeZone = "Europe/Paris";
    };

    programs = {
      gnupg.agent = {
        enable = true;
      };
      ssh = {
        startAgent = true;
      };
      zsh = {
        enable = true;
      };
    };
  };
}
