{
  config,
  lib,
  ...
}: let
  name = builtins.baseNameOf ./.;
  subname = "vdirsyncer";
  cfg = config.hm.flavors.${name}.${subname};

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
  options = {
    hm = {
      flavors = {
        ${name} = {
          ${subname} = {
            enable =
              lib.mkDependEnabledOption ''
                Install ${name}.${subname} Home-Manager flavor.
              ''
              config.hm.flavors.${name}.enable;
          };
        };
      };
    };
  };

  config = lib.mkIf cfg.enable {
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
  };
}
