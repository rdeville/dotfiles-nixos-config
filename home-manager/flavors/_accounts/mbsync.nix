{config, lib, ...}: let
  name = builtins.baseNameOf ./.;
  cfg = config.hm.flavors.${name};

  mbsyncAccounts = builtins.filter (account: account.mbsync.enable) (
    builtins.attrValues config.accounts.email.accounts
  );
in lib.mkIf cfg.enable {
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
