{
  inputs,
  lib,
  ...
}:
builtins.listToAttrs (
  builtins.concatMap (
    host: let
      pkgs =
        inputs.nixos.homeManagerModules.lib.pkgsForSystem
        (
          import ./machines/${host}/base.nix
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
      (
        builtins.filter (user: (
          user != "keys" && user != "assets"
        )) (lib.listDirs ./machines/${host})
      )
  )
  (
    builtins.filter (host: (
      host != "keys" && host != "assets"
    )) (lib.listDirs ./machines)
  )
)
