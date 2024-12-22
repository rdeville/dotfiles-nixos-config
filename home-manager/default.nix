{
  config,
  lib,
  pkgs,
  hm,
  ...
}: let
  cfg = config.hm;

  accountSoft = import ../configs/accounts;

  accounts =
    builtins.map (
      item:
        import ../configs/accounts/${item} {
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
                if cfg.isGui
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
  imports = builtins.map (item: ./${item}) (lib.importDir ./.);

  options = {
    hm = {
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
    inherit hm;

    sops = {
      secrets = mkAccountSops;
    };

    accounts = {
      calendar = {
        basePath = "${config.xdg.dataHome}/calendar";
        accounts = mkAccount "calendar";
      };
      contact = {
        basePath = "${config.xdg.dataHome}/contact";
        accounts = mkAccount "contact";
      };
      email = {
        maildirBasePath = "${config.xdg.dataHome}/mail";
        accounts = mkAccount "email";
      };
    };

    awesomerc = {
      enable = config.hm.presets.gui.enable;
    };
    direnvrc = {
      enable = true;
    };
    neovimrc = {
      enable = true;
    };
    tmuxrc = {
      enable = true;
    };
    zshrc = {
      enable = true;
    };
    dotgit-sync = {
      enable = config.hm.presets.main.enable;
    };
  };
}
