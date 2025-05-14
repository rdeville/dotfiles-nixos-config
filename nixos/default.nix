{
  inputs,
  config,
  lib,
  ...
}: let
  cfg = config.os;
in {
  config = {
    home-manager = {
      useGlobalPkgs = false;
      useUserPackages = true;
      extraSpecialArgs = {
        # Here the magic happens with inputs into home-manager
        inherit inputs lib;
      };
      users = builtins.foldl' (acc: user:
        {
          # Here is the magic to manage both HM/Nixos in a clean homogeneous way
          "${user}" = {
            imports = [
              ../home-manager/_modules.nix
              ../machines/${cfg.hostName}/${user}
            ];
          };
        }
        // acc) {} (
        builtins.filter (host: (
          # Ignore folders machines/_*
          builtins.match "_.*" host != []
        )) (lib.listDirs ../machines/${cfg.hostName})
      );
    };
  };
}
