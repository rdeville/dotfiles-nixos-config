{
  userCfg,
  lib,
  pkgs,
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

  sops =
    pkgs.lib.mkIf (
      userCfg.sops.enable && builtins.hasAttr "defaultSopsFile" userCfg.sops
    ) {
      age = {
        # This is using an age key that is expected to already be in the
        # filesystem
        # In my case, this key is written by a direnv method when I log in but
        # you can specify it in your user configuration.
        keyFile =
          if (builtins.hasAttr "keyFile" userCfg.sops)
          then userCfg.sops.keyFile
          else "/tmp/age/age-${userCfg.username}@${userCfg.hostname}";
      };
      defaultSopsFile = userCfg.sops.defaultSopsFile;
    };

  accounts = {
    email = {
      maildirBasePath = ".local/share/mails";
      accounts = builtins.mapAttrs (_: value: mkLib.mkEmailCfg userCfg value) userCfg.accounts;
    };
    calendar = {
      basePath = ".local/share/calendars";
      accounts = builtins.mapAttrs (_: value: mkLib.mkCalendarCfg userCfg value) userCfg.accounts;
    };
    contact = {
      basePath = ".local/share/contacts";
      accounts = builtins.mapAttrs (_: value: mkLib.mkContactCfg userCfg value) userCfg.accounts;
    };
  };
}
# // userCfg.home-manager

