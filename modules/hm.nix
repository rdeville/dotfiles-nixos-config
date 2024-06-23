{
  inputs,
  # config,
  # pkgs,
  # allSystems,
  # home-manager,
  # microvm,
  # nixos-shell,
  # nixpkgs,
  # nixgl,
  # sops-nix,
  # colors,
  # direnv,
  ...
}: let
  cfg = config.hm;
  home-manager = inputs.home-manager;
  nixpkgs = inputs.nixpkgs;
  nixgl = inputs.nixgl;
  sops-nix = inputs.sops-nix;
  mkLib = import ../lib/hm.nix {
    inherit
      home-manager
      nixpkgs
      nixgl
      sops-nix
      ;
  };
in {
  options.hm = {
    userCfg = pkgs.lib.mkOption {
      type = pkgs.lib.types.anything;
      default = {};
    };
  };
  config = mkLib.mkHomeConfiguration cfg.userCfg;
}
