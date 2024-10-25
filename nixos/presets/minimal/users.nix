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
          shell = lib.mkForce pkgs.zsh;
          isNormalUser = if "${user}" == "root" then false else true;
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
