{
  mkLib,
  userCfg,
  ...
}: let
  tuiAccounts = {
    email = {
      thunderbird.enabled = false;
      primary = false;
    };
    calendar = {
      khal.enabled = true;
      vdirsyncer.enabled = true;
      primary = false;
    };
    contact = {
      khard.enabled = true;
      vdirsyncer.enabled = true;
      primary = false;
    };
  };

  guiAccounts = {
    email = {
      thunderbird.enabled = true;
    };
    calendar = {
      khal.enabled = false;
      vdirsyncer.enabled = false;
    };
    contact = {
      khard.enabled = false;
      vdirsyncer.enabled = false;
    };
  };

  userAccounts = builtins.concatLists (
    builtins.map (
      account:
        import ./${account} {
          inherit userCfg mkLib tuiAccounts guiAccounts;
        }
    )
    userCfg.accounts
  );

  accounts = builtins.listToAttrs (
    builtins.filter (
      account: (
        builtins.any (
          userAccounts: userAccounts == account.value.address
        )
        userCfg.accounts
      )
    )
    userAccounts
  );
in
  accounts
