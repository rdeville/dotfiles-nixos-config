{
  inputs,
  lib,
  ...
}:
builtins.foldl' (acc: host:
    builtins.foldl' (acc: user:
      {
        "${user}@${host}" = inputs.home-manager.lib.homeManagerConfiguration {
          pkgs = import inputs.nixpkgs {
            system = "x86_64-linux";
          };
          modules = [
            ./machines/${host}/${user}
            ./home-manager/_modules.nix
          ];
          extraSpecialArgs = {
            inherit inputs lib;
          };
        };
      }
      // acc) {} (
      builtins.filter (user: (
        user != "keys" && user != "assets"
      )) (lib.listDirs ./machines/${host})
    )
    // acc) {} (
  builtins.filter (host: (
    host != "keys" && host != "assets"
  )) (lib.listDirs ./machines)
)
