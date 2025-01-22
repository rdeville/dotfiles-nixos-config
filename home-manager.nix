{
  inputs,
  lib,
  ...
}:
builtins.listToAttrs (
  builtins.concatLists (builtins.map (
    host: let
      pkgs =
        inputs.nixos.homeManagerModules.lib.pkgsForSystem
        (
          import ./configs/hosts/${host}/base.nix
        )
        .system;
    in
      builtins.map (
        user: {
          name = "${user}@${host}";
          value = inputs.home-manager.lib.homeManagerConfiguration {
            inherit pkgs;
            modules = [
              (import ./home-manager/_modules.nix {
                inherit inputs host user;
              })
            ];
            extraSpecialArgs = {
              inherit inputs lib;
            };
          };
        }
      )
      (lib.listDirs ./configs/hosts/${host})
  ) (lib.listDirs ./configs/hosts))
)
