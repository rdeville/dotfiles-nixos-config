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
        inherit inputs;
      };
      users = builtins.foldl' (acc: user:
        {
          # Here is the magic to manage both HM/Nixos in a clean homogeneous way
          "${user}" = import ../home-manager/_modules.nix {
            host = cfg.hostName;
            inherit inputs user;
          };
        }
        // acc) {} (
        builtins.filter (host: (
          host != "keys" && host != "assets"
        )) (lib.listDirs ../machines/${cfg.hostName})
      );
    };
  };
}
