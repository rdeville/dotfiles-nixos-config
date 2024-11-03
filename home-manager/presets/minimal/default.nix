{
  inputs,
  userCfg,
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

  sops =
    if (userCfg ? sops)
    then userCfg.sops
    else {};

  accounts = {
    email = {
      maildirBasePath = ".local/share/mails";
      accounts =
        builtins.mapAttrs
        (_: value: accountsLib.mkEmailCfg userCfg value)
        (
          if userCfg ? accounts
          then userCfg.accounts
          else {}
        );
    };
    calendar = {
      basePath = ".local/share/calendars";
      accounts =
        builtins.mapAttrs
        (_: value: accountsLib.mkCalendarCfg userCfg value)
        (
          if userCfg ? accounts
          then userCfg.accounts
          else {}
        );
    };
    contact = {
      basePath = ".local/share/contacts";
      accounts =
        builtins.mapAttrs
        (_: value: accountsLib.mkContactCfg userCfg value)
        (
          if userCfg ? accounts
          then userCfg.accounts
          else {}
        );
    };
  };
}
