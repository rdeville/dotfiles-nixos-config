# System User
{
  pkgs,
  cfg,
  ...
}: {
  users = {
    defaultUserShell = pkgs.zsh;
    users = builtins.listToAttrs (
      builtins.map (username: {
        name = "${username}";
        value = {
          isNormalUser = true;
          password = "${username}";
          extraGroups =
            ["networkmanager"]
            ++ (
              if cfg.users.${username}.presets.sudo
              then ["wheel"]
              else []
            );
        };
      }) (builtins.attrNames cfg.users)
    );
  };

  programs = {
    zsh = {
      enable = true;
    };
  };
}
