{
  inputs,
  host,
  user,
  ...
}: {
  imports = [
    # Local Modules
    ../configs/hosts/${host}/${user}
    ../home-manager
    # External Modules
    inputs.nixos.inputs.sops-nix.homeManagerModules.sops
    inputs.nixos.inputs.nix-index-database.hmModules.nix-index
    # Internal Modules
    inputs.nixos.homeManagerModules.hm
    # Personnal home-manager packaged dotfiles
    inputs.awesomerc.homeManagerModules.awesomerc
    inputs.direnvrc.homeManagerModules.direnvrc
    inputs.neovimrc.homeManagerModules.neovimrc
    inputs.tmuxrc.homeManagerModules.tmuxrc
    inputs.zshrc.homeManagerModules.shellrc
    # Personnal packaged programs
    inputs.dotgit-sync.homeManagerModules.dotgit-sync
  ];
}
