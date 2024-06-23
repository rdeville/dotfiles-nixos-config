{
  mkLib,
  userCfg,
  ...
}: let
  userAccounts =
    builtins.foldl' (
      acc: elem:
        acc
        ++ [
          (
            import elem {
              inherit userCfg mkLib;
            }
          )
        ]
    )
    []
    (mkLib.mkImportDir ./${userCfg.username});
  accounts = builtins.listToAttrs (builtins.map (
      account:
        account
        // {
          name = mkLib.mkSlugEmail account.name;
        }
    )
    (builtins.filter (account: (
        builtins.any (
          userAccounts:
            userAccounts == account.name
        )
        userCfg.accounts
      ))
      userAccounts));
in
  accounts
