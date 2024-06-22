{
  config,
  lib,
  pkgs,
  cfg,
  ...
}: let
  notmuchAccounts = builtins.filter (account: account.notmuch.enable) (
    builtins.attrValues config.accounts.email.accounts
  );
in {
  # Let Home Manager install and manage itself.
  programs = {
    notmuch = {
      enable = notmuchAccounts != [];
    };
  };
}
