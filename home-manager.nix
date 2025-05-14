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
            system =
              if host == "palpatine"
              then "aarch64-darwin"
              else "x86_64-linux";
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
        # Ignore folders machines/*/_*
        builtins.match "_.*" user != []
      )) (lib.listDirs ./machines/${host})
    )
    // acc) {} (
  builtins.filter (host: (
    # Ignore folders machines/_*
    builtins.match "_.*" host != []
  )) (lib.listDirs ./machines)
)
