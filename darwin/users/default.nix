{
  config,
  pkgs,
  ...
}: let
  cfg = config.os.users;
in {
  imports = [
    ./options.nix
  ];

  config = {
    system = {
      primaryUser = builtins.toString (builtins.filter (item: let
        user = cfg.users.${item};
      in
        user.isPrimary) (builtins.attrNames cfg.users));
    };

    users = {
      users =
        builtins.mapAttrs (
          name: user: {
            inherit
              (user)
              openssh
              home
              ;
            shell = pkgs.${user.shell};
          }
        )
        cfg.users;
      groups = builtins.foldl' (
        acc: elem:
          (
            builtins.foldl' (acc: group:
              {
                ${group} = {
                  members = [
                    elem
                  ];
                };
              }
              // acc) {}
            cfg.users.${elem}.extraGroups
          )
          // acc
      ) {} (builtins.attrNames cfg.users);
    };

    programs = builtins.listToAttrs (
      builtins.map (
        name: let
          inherit (cfg.users.${name}) shell;
        in {
          name = shell;
          value = {
            enable = true;
          };
        }
      ) (builtins.attrNames cfg.users)
    );
  };
}
