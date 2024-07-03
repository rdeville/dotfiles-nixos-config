{
  config,
  lib,
  pkgs,
  ...
}: let
  mbsyncAccounts = builtins.filter (account: account.mbsync.enable) (
    builtins.attrValues config.accounts.email.accounts
  );
in {
  programs = {
    mbsync = {
      enable = mbsyncAccounts != [];
    };
  };

  services = {
    mbsync = {
      enable = mbsyncAccounts != [];
      # Every 5 minutes
      frequency = "*:0/5";
      # preExec = "";
      # postExec = "";
    };
  };
}
