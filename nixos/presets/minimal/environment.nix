{
  hostCfg,
  userCfg,
  pkgs,
  ...
}: {
  environment = {
    # Environment Variables
    variables = {
      TERMINAL = "${hostCfg.terminal}";
      EDITOR = "${hostCfg.editor}";
      VISUAL = "${hostCfg.editor}";
    };

    # System-Wide Packages
    systemPackages = with pkgs; [
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
  };
}
