{
  userCfg,
  pkgs,
  config,
  ...
}: let
  main =
    if userCfg.presets.main
    then [./presets/main]
    else [];
  gui =
    if userCfg.presets.gui
    then [./presets/gui]
    else [];
  imports =
    if userCfg.presets.container
    then [
      ./presets/minimal
    ]
    else
      [
        ./presets/minimal
        ./presets/common
      ]
      ++ main
      ++ gui;

  mkLib = import ../lib/accounts;
in {
  imports = imports ++ (mkLib.mkImportDir ./flavors);

  home = {
    stateVersion = userCfg.stateVersion;
  };

  systemd = {
    user = {
      startServices = "sd-switch";
    };
  };

  sops = pkgs.lib.mkIf (userCfg ? sops) userCfg.sops;

  accounts = {
    email = {
      maildirBasePath = ".local/share/mails";
      accounts =
        builtins.mapAttrs
        (_: value: mkLib.mkEmailCfg userCfg value)
        userCfg.accounts;
    };
    calendar = {
      basePath = ".local/share/calendars";
      accounts =
        builtins.mapAttrs
        (_: value: mkLib.mkCalendarCfg userCfg value)
        userCfg.accounts;
    };
    contact = {
      basePath = ".local/share/contacts";
      accounts =
        builtins.mapAttrs
        (_: value: mkLib.mkContactCfg userCfg value)
        userCfg.accounts;
    };
  };
}
