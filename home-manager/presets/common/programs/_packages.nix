{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      # Terminal
      coreutils # GNU Utilities
      lshw # Hardware Config
      neovim # Text Editor
      nix-tree # Browse Nix Store
      pciutils # Manage PCI
      smartmontools # Disk Health
      usbutils # Manage USB
      tmux # Terminal Multiplexer
      xdg-utils # Environment integration
      zsh # Shell Emulator
      dbus
      # direnv # Automate directory environment loadin
      # nix-direnv # Integration betwwen direnv and nix
      devenv
      mr # MyRepos, multiple git repo manager
      tig # Text Iterface Git
      tree # Show folder as tree
      fzf # Fuzzy Finder
      ripgrep # Perl Grep
      xclip # Copy to clipboard

      # File Management
      p7zip # Zip Encryption
      rsync # Syncer - $ rsync -r dir1/ dir2/
      unzip # Zip Files
      zip # Zip

      # Audio
      pulseaudio # Audio Server/Control
      # TODO: @rdeville Change to another in few month as pulsemixer is not
      #       maintained anymore, like ncpamixer
      pulsemixer # TUI Audio Control
      # TODO: @rdeville Get info about pipewire and qpwgraph sometimes
      # qpwgraph        # Pipewire Graph Manager
      pipewire # Audio Server/Control

      # Diff build for flakes/nix
      nvd

      # File encryption software
      age
    ];
  };
}
