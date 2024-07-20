{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      # Terminal
      bash # Shell Emulator
      bmon # Process and Ressource Manager
      btop # Resource Manager
      curl # Retriever
      git # Version Control
      htop # Process Manager
      killall # Process Killer
      zsh # Shell Emulator
      bc # Bash Calculator
    ];
  };
}
