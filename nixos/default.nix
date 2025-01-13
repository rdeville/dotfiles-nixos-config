{
  config,
  inputs,
  lib,
  ...
}: {
  imports = builtins.map (item: ./${item}) (lib.importDir ./.);

  config = {
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      users = builtins.listToAttrs (
        builtins.map (
          user: {
            name = "${user}";
            value = {
              imports = [
                # Local Modules
                ../configs/hosts/${config.os.hostName}/${user}
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
            };
          }
        )
        (lib.listDirs ../configs/hosts/${config.os.hostName})
      );
    };
  };
}
