{
  inputs,
  host,
  user,
  ...
}: {
  imports = [
    ./overlays
    # Local Modules
    ../machines/${host}/${user}
    ../home-manager
    # External Modules
    inputs.nixos.inputs.sops-nix.homeManagerModules.sops
    inputs.nixos.inputs.nix-index-database.hmModules.nix-index
    # Internal Modules
    inputs.nixos.homeManagerModules.hm
    # Personal home-manager packaged dotfiles
    inputs.awesomerc.homeManagerModules.awesomerc
    inputs.direnvrc.homeManagerModules.direnvrc
    inputs.neovimrc.homeManagerModules.neovimrc
    inputs.tmuxrc.homeManagerModules.tmuxrc
    # Personal packaged programs
    inputs.dotgit-sync.homeManagerModules.dotgit-sync
  ];
}
