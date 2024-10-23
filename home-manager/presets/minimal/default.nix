{
  inputs,
  userCfg,
  pkgs,
  ...
}: let
  mkLib = import ../../../lib/default.nix {inherit inputs;};
  accountsLib = import ../../../lib/accounts;

  imports = builtins.map (item: ./${item}) ((builtins.filter (
      item:
        item != "default.nix"
    ) (mkLib.mkListFiles ./.))
    ++ (mkLib.mkListDirs ./.));
in {
  imports = imports;

  home = {
    stateVersion = userCfg.stateVersion;
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  systemd = {
    user = {
      startServices = "sd-switch";
    };
  };

  sops = pkgs.lib.mkIf (userCfg ? sops) userCfg.sops;

  accounts = {
    email = {
      maildirBasePath = ".local/share/mails";
      accounts =
        builtins.mapAttrs
        (_: value: accountsLib.mkEmailCfg userCfg value)
        userCfg.accounts;
    };
    calendar = {
      basePath = ".local/share/calendars";
      accounts =
        builtins.mapAttrs
        (_: value: accountsLib.mkCalendarCfg userCfg value)
        userCfg.accounts;
    };
    contact = {
      basePath = ".local/share/contacts";
      accounts =
        builtins.mapAttrs
        (_: value: accountsLib.mkContactCfg userCfg value)
        userCfg.accounts;
    };
  };
}
