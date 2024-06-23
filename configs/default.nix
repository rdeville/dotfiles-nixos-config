{
  mkLib,
  direnv,
  ...
}: let
  defaults = {
    system = "x86_64-linux";
    stateVersion = "24.05";
    editor = "nvim";
    terminal = "kitty";
    presets = {
      gui = false;
      main = false;
      game = false;
      server = false;
      work = false;
      container = false;
    };
    # location = "$HOME/.cache/nix/.setup";
    modules = [];
  };

  modules = [
    direnv.homeManagerModules.direnv
  ];

  mergeUserWithDefaults = hostname: userCfgs:
  # Must do accounts after merge of presets is done
    builtins.mapAttrs (
      username: userCfg:
        userCfg
        // {
          accounts = import ./accounts {inherit mkLib userCfg;};
        }
    )
    (builtins.mapAttrs (username: userCfg:
      defaults
      // userCfg
      // {
        hostname = hostname;
        username = username;
        presets =
          defaults.presets
          // (
            if (userCfg ? presets)
            then userCfg.presets
            else
              {}
              // userCfg
          );
        accounts =
          if userCfg ? accounts
          then userCfg.accounts
          else {};
        modules =
          if userCfg ? modules
          then modules ++ userCfg.modules
          else modules;
      })
    userCfgs);

  mergeHostWithDefaults = hostCfgs:
    builtins.mapAttrs (
      hostname: hostCfg:
        defaults
        // hostCfg
        // {
          hostname = hostname;
          users = mergeUserWithDefaults hostname hostCfg.users;
          presets = defaults.presets // hostCfg.presets;
        }
    )
    hostCfgs;
in {
  # hosts = mkLib.mkDebug (mergeHostWithDefaults (import ./hosts)) mergeHostWithDefaults (import ./hosts);
  hosts = mergeHostWithDefaults (import ./hosts);
  vms = mergeHostWithDefaults (import ./vms);
}
