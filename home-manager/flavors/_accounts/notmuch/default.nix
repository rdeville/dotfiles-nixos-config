{config, lib, ...}: let
  name = builtins.baseNameOf ../.;
  cfg = config.hm.flavors.${name};

  notmuchAccounts = builtins.filter (account: account.notmuch.enable) (
    builtins.attrValues config.accounts.email.accounts
  );
in lib.mkIf cfg.enable {
  programs = {
    notmuch = {
      enable = notmuchAccounts != [];
    };
  };
}
