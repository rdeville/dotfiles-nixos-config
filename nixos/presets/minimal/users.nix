# System User
{
  pkgs,
  lib,
  hostCfg,
  ...
}: let
  users = hostCfg.users;
  extraGroups = user:
    [
      "networkmanager"
    ]
    ++ [(lib.mkIf user.sudo "wheel")];
in {
  users = {
    defaultUserShell = pkgs.zsh;
    mutableUsers = true;
    users = builtins.listToAttrs (
      builtins.map (user: {
        name = "${user}";
        value = {
          isNormalUser = true;
          extraGroups = extraGroups users.${user};
        };
      }) (builtins.attrNames users)
    );
  };

  programs = {
    zsh = {
      enable = true;
    };
  };
}
