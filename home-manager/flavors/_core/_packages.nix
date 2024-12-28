{pkgs, ...}: let
  linuxPkgs = with pkgs; [
    lshw # Hardware Config
    usbutils # Manage USB
  ];
  darwinPkgs = [];
in {
  home = {
    packages = with pkgs; [
      age # Encryption tools
        alejandra # Nix formatter
      bash # Shell Emulator
      bmon # Process and Ressource Manager
      btop # Resource Manager
      colordiff # Better diff output
      coreutils # GNU Utilities
        comma # Nix Shell utils
      curl # Retriever
      dbus
      devbox # Isolated development tools
      devenv # Isolated nix development tools
      diffutils # Command showing diff
      direnv # Automated development tools
      fzf # Fuzzy Finder
      gcc # C++ compiler
      git # Version Control
      ghostscript # Printing file manipulation
      htop # Process Manager
      jq # json manipulation tool
      killall # Process Killer
      lshw # Hardware Config
      neovim # Text Editor
      pciutils # Manage PCI
      p7zip # Zip Encryption
      smartmontools # Disk Health
      sops # Encryption tools
      ripgrep # Perl Grep
      rsync # Syncer - $ rsync -r dir1/ dir2/
      tig # Text Iterface Git
      tmux # Terminal multiplexer
      tree # Show folder as tree
      usbutils # Manage USB
      unzip # Zip Files
      xclip # Copy to clipboard
      xdg-utils # Environment integration
      zip # Zip

      # NixOS CLI related packages
      nix-tree # Browse Nix Store
      nh # Wrapper above nixos-rebuild or home-manager
      nvd # Diff build for flakes/nix
    ];
  };
}
