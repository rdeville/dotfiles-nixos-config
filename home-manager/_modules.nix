{inputs, ...}: {
  imports = [
    # External Modules
    inputs.nixos.inputs.sops-nix.homeManagerModules.sops
    inputs.nixos.inputs.nix-index-database.homeModules.nix-index
    # Personal home-manager packaged config dotfiles
    inputs.awesomerc.homeManagerModules.awesomerc
    inputs.direnvrc.homeManagerModules.direnvrc
    inputs.neovimrc.homeManagerModules.neovimrc
    inputs.tmuxrc.homeManagerModules.tmuxrc
    # Personal home-manager packaged data dotfiles
    inputs.tmuxdata.homeManagerModules.tmuxdata
    inputs.dotgit-sync.homeManagerModules.dotgit-sync
    # Overlays
    ../overlays
    # Local Modules
    ../home-manager
  ];
}
