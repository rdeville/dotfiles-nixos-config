{inputs, ...}: {
  imports = [
    # External Modules
    inputs.nixos.inputs.sops-nix.homeManagerModules.sops
    inputs.nixos.inputs.nix-index-database.homeModules.nix-index
    # Personal home-manager packaged config dotfiles
    inputs.neovimrc.homeManagerModules.neovimrc
    # Personal home-manager packaged data dotfiles
    inputs.dotgit-sync.homeManagerModules.dotgit-sync
    # Overlays
    ../overlays
    # Local Modules
    ../home-manager
  ];
}
