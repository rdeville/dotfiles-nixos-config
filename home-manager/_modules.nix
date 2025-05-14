{inputs, ...}: {
  imports = [
    # External Modules
    inputs.nixos.inputs.sops-nix.homeManagerModules.sops
    inputs.nixos.inputs.nix-index-database.hmModules.nix-index
    # Internal Modules
    inputs.nixos.homeManagerModules.hm
    # Personal home-manager packaged config dotfiles
    inputs.awesomerc.homeManagerModules.awesomerc
    inputs.direnvrc.homeManagerModules.direnvrc
    inputs.neovimrc.homeManagerModules.neovimrc
    inputs.tmuxrc.homeManagerModules.tmuxrc
    # Personal home-manager packaged data dotfiles
    inputs.tmuxdata.homeManagerModules.tmuxdata
    # Personal packaged programs
    inputs.dotgit-sync.homeManagerModules.dotgit-sync
    # Overlays
    ../overlays
    # Local Modules
    ../home-manager
  ];
}
