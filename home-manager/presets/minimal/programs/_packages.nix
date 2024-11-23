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
      bc # Bash Calculator
      gcc # C++ compiler
      sops # Encryption tools
      age # Encryption tools
      nh # nixos-rebuild & home-manager wrapper
    ];
  };
}
