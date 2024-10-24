{
  hostCfg,
  pkgs,
  lib,
  ...
}: {
  # For more information, see `man configuration.nix` or
  # https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system = {
    stateVersion = hostCfg.stateVersion;
  };

  nixpkgs = {
    hostPlatform = hostCfg.system;
  };

  # Use the systemd-boot EFI boot loader.
  boot = {
    loader = {
      # systemd-boot = {
      #   enable = true;
      # };
      efi = {
        canTouchEfiVariables = true;
      };
      grub = {
        enable = true;
        device = "nodev";
        useOSProber = true;
        efiSupport = true;
      };
    };
  };

  nix = {
    settings = {
      experimental-features = lib.mkDefault [
        "nix-command"
        "flakes"
      ];
    };
  };

  networking = {
    hostName = hostCfg.hostName;
  };

  console = {
    font = lib.mkDefault "Lat2-Terminus16";
    keyMap = lib.mkDefault "fr";
  };

  users = {
    defaultUserShell = pkgs.zsh;
    users = {
      rdeville = {
        initialPassword = "password";
        isNormalUser = true;
        # Enable ‘sudo’ for the user.
        extraGroups = ["wheel"];
        packages = with pkgs; [
          keepassxc
        ];
      };
    };
  };
}
