{
  config,
  lib,
  mkLib,
  pkgs,
  userCfg,
  ...
}: let
  vdirsyncerAccounts = builtins.filter (account: account.vdirsyncer.enable) (
    builtins.attrValues config.accounts.calendar.accounts
  );
  sopsAccountsEntry =
    builtins.listToAttrs
    (builtins.map (account: {
        name = "accounts/${builtins.replaceStrings ["_at_" "_"] ["@" "."] account.name}";
        value = {};
      })
      vdirsyncerAccounts);
in {
  programs = {
    vdirsyncer = {
      enable = vdirsyncerAccounts != [];
    };
  };

  sops = lib.mkIf (vdirsyncerAccounts != [] && (builtins.hasAttr "sops" userCfg && userCfg.sops.enable)) {
    secrets = sopsAccountsEntry;
  };

  services = {
    vdirsyncer = {
      enable = vdirsyncerAccounts != [];
      # Every 15 minutes
      frequency = "*:0/15";
      verbosity = "DEBUG";
    };
  };
}
