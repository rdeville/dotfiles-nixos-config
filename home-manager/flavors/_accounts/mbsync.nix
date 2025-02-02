{
  config,
  lib,
  ...
}: let
  name = builtins.baseNameOf ./.;
  subname = "mbsync";
  cfg = config.hm.flavors.${name}.${subname};

  mbsyncAccounts = builtins.filter (account: account.mbsync.enable) (
    builtins.attrValues config.accounts.email.accounts
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
  };
}
