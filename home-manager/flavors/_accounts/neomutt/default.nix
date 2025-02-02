{
  config,
  lib,
  ...
}: let
  name = builtins.baseNameOf ../.;
  subname = builtins.baseNameOf ./.;
  cfg = config.hm.flavors.${name}.${subname};

  neomuttAccounts = builtins.filter (account: account.neomutt.enable) (
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
    # Let Home Manager install and manage itself.
    programs = {
      neomutt = {
        enable = neomuttAccounts != [];
        checkStatsInterval = 300;
        # unmailboxes
        # extraConfig = "";
        # settings
        sidebar = {
          enable = true;
          format = "%D %B %* [%?N?%N / ?%S]";
          shortPath = true;
          width = 25;
        };
        # binds = {
        #   <*> = {
        #     action;
        #     key;
        #     map;
        #   };
        # };
        # macros = {
        #   <*> = {
        #     action;
        #     key;
        #     map;
        #   };
        # };
      };
    };
  };
}
