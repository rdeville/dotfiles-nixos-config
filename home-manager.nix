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
            # if host == "palpatine"
            # then "aarch64-darwin"
            # else "x86_64-linux";
          };
          modules = [
            inputs.nixos.homeManagerModules.hm
            ./machines/${host}/users/${user}
            ./home-manager/_modules.nix
          ];
          extraSpecialArgs = {
            inherit inputs lib;
          };
        };
      }
      // acc) {} (
      builtins.filter (user: (
        # Ignore folders machines/*/users/_*
        builtins.match "_.*" user != []
      )) (lib.listDirs ./machines/${host}/users)
    )
    // acc) {} (
  builtins.filter (
    host: (
      # Ignore folders machines/_* and folders machines/*/ that does not have users
      builtins.match "_.*" host != [] && builtins.pathExists ./machines/${host}/users
    )
  ) (lib.listDirs ./machines)
)
