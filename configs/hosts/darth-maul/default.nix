{
  config,
  lib,
  pkgs,
  ...
}: let
  osBase = import ../base.nix;
  base = import ./base.nix;

  users = {
    rdeville = {
      isSudo = true;
      inherit (osBase.users) openssh;

    };
    root = {
      inherit (osBase.users) openssh;
    };
  };

  secrets = builtins.listToAttrs (builtins.map (user: {
    name = "users/${user}/password";
    value = {
      neededForUsers = true;
    };
  }) (builtins.filter (user: user != "test") (builtins.attrNames users)));
in {
  imports = [
    ./hardware-configuration.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      systemd-boot = {
        enable = true;
      };

      efi = lib.mkDefault {
        canTouchEfiVariables = true;
      };

      # grub = {
      #   enable = true;
      #   device = "nodev";
      #   useOSProber = true;
      #   efiSupport = true;
      # };
    };
  };

  networking = {
    useDHCP = true;
  };

  nixpkgs = {
    hostPlatform = base.system;
  };

  services = {
    xserver = {
      videoDrivers = ["nvidia"];
    };
  };

  virtualisation = {
    libvirtd = {
      enable = true;
    };
  };

  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };

    graphics = {
      enable = true;
    };

    nvidia = {
      powerManagement = {
        enable = false;
        finegrained = false;
      };
      open = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.latest;
    };
  };

  sops = {
    inherit secrets;
    age = {
      inherit (osBase.sops) keyFile;
    };
    defaultSopsFile = ./secrets.enc.yaml;
  };

  nixpkgs = {
    config = {
      allowUnfreePredicate = pkg:
        builtins.elem (lib.getName pkg) [
          "discord"
          "nvidia-settings"
          "nvidia-x11"
          "steam"
          "steam-unwrapped"
        ];
    };
  };

  os = {
    inherit (base) hostName isGui isMain system;

    users = {
      inherit users;
    };

    flavors = {
      _core = {
        nix-ld = {
          enable = true;
        };
      };

      display-manager = {
        enable = true;
        ly = {
          enable = true;
        };
      };

      window-manager = {
        enable = true;
        awesome = {
          enable = true;
        };

        hyprland = {
          enable = true;
        };
      };

      ssh-server = {
        enable = true;
      };

      steam = {
        enable = true;
      };
    };
  };
}
