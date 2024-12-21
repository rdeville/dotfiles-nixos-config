{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.os;
  defaultPkgs = with pkgs; [
    # Terminal
    btop # Resource Manager
    htop # Process Manager
    coreutils # GNU Utilities
    git # Version Control
    killall # Process Killer
    lshw # Hardware Config
    pciutils # Manage PCI
    smartmontools # Disk Health
    usbutils # Manage USB
    curl # Retriever
    xdg-utils # Environment integration
    neovim # Text Editor
    tmux # Terminal multiplexer
    jq # json manipulation tool

    # NixOS CLI related packages
    nix-tree # Browse Nix Store
    nh # Wrapper above nixos-rebuild or home-manager
    home-manager # Home manage
    devbox # Isolated development tools
    direnv # Automated development tools

    # File Management
    p7zip # Zip Encryption
    rsync # Syncer - $ rsync -r dir1/ dir2/
    unzip # Zip Files
    zip # Zip
  ];

  guiPkgs = with pkgs; [
    # Terminal
    kitty # Terminal Emulator
    xterm # Fallback Terminal Emulator

    # Audio
    pulseaudio # Audio Server/Control
    pavucontrol # CLI Audio Control
    # TODO: @rdeville Change to another in few month as pulsemixer is not
    #       maintained anymore, like ncpamixer
    pulsemixer # TUI Audio Control
    # TODO: @rdeville Get info about pipewire and qpwgraph sometimes
    # qpwgraph        # Pipewire Graph Manager
    pipewire # Audio Server/Control
  ];
in {
  environment = {
    variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };

    # System-Wide Packages
    systemPackages =
      defaultPkgs
      ++ (
        if cfg.isGui
        then guiPkgs
        else []
      );
  };

  hardware = {
    pulseaudio = {
      enable = false;
    };
  };

  services = {
    # Sound
    pipewire = {
      enable = true;
      pulse.enable = true;
      jack.enable = true;
    };
  };
}
