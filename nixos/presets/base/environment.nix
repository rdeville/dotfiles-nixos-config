{
  pkgs,
  cfg,
  ...
}: {
  environment = {
    # Environment Variables
    variables = {
      TERMINAL = "${cfg.terminal}";
      EDITOR = "${cfg.editor}";
      VISUAL = "${cfg.editor}";
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
      nix-tree # Browse Nix Store
      pciutils # Manage PCI
      smartmontools # Disk Health
      usbutils # Manage USB
      curl # Retriever
      xdg-utils # Environment integration
      neovim # Text Editor

      # File Management
      p7zip # Zip Encryption
      rsync # Syncer - $ rsync -r dir1/ dir2/
      unzip # Zip Files
      zip # Zip
    ];
  };
}
