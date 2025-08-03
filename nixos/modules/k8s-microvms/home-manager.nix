{
  inputs,
  ...
}: {
  imports = [
    # External Modules
    inputs.nixos.inputs.sops-nix.homeManagerModules.sops
    inputs.nixos.inputs.nix-index-database.homeModules.nix-index
    # Overlays
    ../../../overlays
    # Local Modules
    ../../../home-manager/options.nix
  ];

  hm = {
    flavors = {
      _core = {
        fastfetch.enable = false;
        git.enable = false;
        gpg.enable = false;
        home-manager.enable = false;
        lazygit.enable = false;
        mr.enable = false;
      };
    };
  };
}
