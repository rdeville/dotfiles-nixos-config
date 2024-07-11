{inputs, ...}: let
  pkgsForSystem = (import ./. {inherit inputs;}).pkgsForSystem;
  mkDebug = (import ./. {inherit inputs;}).mkDebug;
  mkImportDir = (import ./. {inherit inputs;}).mkImportDir;

  mkNixOS = cfg:
    inputs.nixpkgs.lib.makeOverridable inputs.nixpkgs.lib.nixosSystem {
      system = cfg.system;
      modules =
        cfg.modules
        ++ [
          inputs.home-manager.nixosModules.home-manager
          # ../nixos/hosts/${cfg.hostname}
          ../nixos/presets
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              # users.user = {pkgs, ...}: {
              #   home.stateVersion = cfg.stateVersion;
              #   home.packages = with pkgs; [
              #     lolcat
              #   ];
              # };
            };
          }
        ];
      specialArgs = {
        pkgs = pkgsForSystem cfg.system;
        # stateVersion = cfg.stateVersion;
        inherit (cfg) stateVersion;
        inherit cfg;
      };
    };

  mkNixVMs-nixos-shell = cfg: (cfg
    // {
      modules = [
        inputs.nixos-shell.nixosModules.nixos-shell
        ../nixos/vms/nixos-shell
      ];
    });

  mkNixVMs-microvm = cfg: (cfg
    // {
      modules = [
        inputs.microvm.nixosModules.microvm
        ../nixos/vms/microvm
      ];
    });

  lib = {
    inherit
      mkDebug
      mkImportDir
      mkNixVMs-nixos-shell
      mkNixVMs-microvm
      mkNixOS
      pkgsForSystem
      ;
  };
in
  lib
