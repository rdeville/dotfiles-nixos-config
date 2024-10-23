{
  inputs,
  hostCfg,
  config,
  lib,
  pkgs,
  ...
}: let
  mkLib = import ../../../lib/default.nix {inherit inputs;};

  presetCfg =
    if hostCfg.presets ? minimal
    then hostCfg.presets.minimal
    else {
      enable = false;
    };

  imports =
    builtins.map (
      item: (import ./${item} {inherit inputs hostCfg presetCfg config lib pkgs;})
    ) (
      (builtins.filter (item: item != "default.nix") (mkLib.mkListFiles ./.))
      ++ (mkLib.mkListDirs ./.)
    );
in {
  inherit imports;

  console = {
    font = "Lat2-Terminus16";
    keyMap = hostCfg.keyMap;
  };

  # Locale configuration
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_MONETARY = "fr_FR.UTF-8";
    };
  };

  # Timezone
  time = {
    timeZone = "Europe/Paris";
  };

  programs = {
    gnupg.agent = {
      enable = true;
    };
    ssh = {
      startAgent = true;
    };
  };
}
