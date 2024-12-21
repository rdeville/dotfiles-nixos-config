{config, ...}: let
  notmuchAccounts = builtins.filter (account: account.notmuch.enable) (
    builtins.attrValues config.accounts.email.accounts
  );
in {
  programs = {
    notmuch = {
      enable = notmuchAccounts != [];
    };
  };
}
