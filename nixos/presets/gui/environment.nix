{pkgs, ...}: {
  environment = {
    # System-Wide Packages
    systemPackages = with pkgs; [
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
  };
}
