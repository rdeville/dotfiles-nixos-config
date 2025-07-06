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
            imports =
              if (builtins.pathExists ../machines/${cfg.hostName}/users/${user}/default.nix)
              then [
                ../home-manager/_modules.nix
                ../machines/${cfg.hostName}/users/${user}
              ]
              else [
                ../home-manager/_modules.nix
              ];
          };
        }
        // acc) {} (builtins.attrNames config.os.users.users);
    };
  };
}
