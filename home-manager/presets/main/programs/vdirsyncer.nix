{config, ...}: let
  vdirsyncerAccounts =
    (
      builtins.filter (account: account.vdirsyncer.enable) (
        builtins.attrValues config.accounts.calendar.accounts
      )
    )
    ++ (
      builtins.filter (account: account.vdirsyncer.enable) (
        builtins.attrValues config.accounts.contact.accounts
      )
    );
in {
  programs = {
    vdirsyncer = {
      enable = vdirsyncerAccounts != [];
    };
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
