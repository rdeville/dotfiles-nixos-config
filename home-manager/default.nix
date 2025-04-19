{
  osConfig,
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
    ./assets
  ];

  options = {
    hm = {
      isMain = lib.mkOption {
        type = lib.types.bool;
        description = "Define HM is for a main computer.";
        default =
          if osConfig ? os.isMain
          then osConfig.os.isMain
          else false;
      };

      isGui = lib.mkOption {
        type = lib.types.bool;
        description = "Define HM is for a gui computer.";
        default =
          if osConfig ? os.isGui
          then osConfig.os.isGui
          else false;
      };

      userAccounts = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        description = "List of user accounts in config/accounts folder.";
        default = [];
        example = [
          "contact@domain.tld"
        ];
      };
    };
  };

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

    programs = {
      tmuxrc = {
        enable = config.hm.flavors._core.enable;
      };
    };

    direnvrc = {
      enable = config.hm.flavors._core.enable;
    };

    neovimrc = {
      enable = config.hm.flavors._core.enable;
    };

    dotgit-sync = {
      enable = config.hm.flavors._core.enable;
    };

    awesomerc = {
      enable = config.hm.flavors._gui.enable;
    };
  };
}
