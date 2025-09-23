{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.hm;

  accountSoft = import ./accounts;

  accounts =
    builtins.map (
      item:
        import ./accounts/${item} {
          inherit lib pkgs config;
        }
    )
    cfg.userAccounts;

  mkAccount = type:
    builtins.listToAttrs
    (builtins.concatLists (builtins.map (
        account:
          if account ? ${type}
          then [
            {
              name = account.slugAddress;
              value =
                (
                  lib.mkImportCfg type account.${type} config.hm
                )
                // (accountSoft.tuiSoft account.${type}.primary).${type};
            }
            {
              name = account.displayName;
              value =
                if cfg.flavors._gui.enable
                then
                  (
                    lib.mkImportCfg type account.${type} config.hm
                  )
                  // accountSoft.guiSoft.${type}
                else {};
            }
          ]
          else []
      )
      accounts));

  mkAccountSops =
    builtins.listToAttrs
    (builtins.concatLists (builtins.map (
        account:
          if account ? sops
          then
            (builtins.map (item: {
              name = item;
              value = account.sops.${item};
            }) (builtins.attrNames account.sops))
          else []
      )
      accounts));
in {
  imports = [
    ./flavors
    ./assets
    ./options.nix
  ];

  config = {
    sops = {
      secrets = mkAccountSops;
    };

    accounts = {
      calendar = {
        basePath = "${config.xdg.dataHome}/calendars";
        accounts = mkAccount "calendar";
      };
      contact = {
        basePath = "${config.xdg.dataHome}/contacts";
        accounts = mkAccount "contact";
      };
      email = {
        maildirBasePath = "${config.xdg.dataHome}/mails";
        accounts = mkAccount "email";
      };
    };

    neovimrc = {
      enable = config.hm.flavors._core.enable;
    };
  };
}
