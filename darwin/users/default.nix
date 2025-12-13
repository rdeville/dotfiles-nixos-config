{
  config,
  pkgs,
  ...
}: let
  cfg = config.os.users;
  defaultGroup = [
    "networkmanager"
  ];
  sudoGroup = user:
    if user.isSudo
    then [
      "wheel"
    ]
    else [];
in {
  config = {
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
            isNormalUser = name != "root";
            extraGroups =
              defaultGroup
              ++ user.extraGroups
              ++ (sudoGroup user);
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
