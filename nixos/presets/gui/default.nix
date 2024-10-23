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
    if hostCfg.presets ? gui
    then hostCfg.presets.gui
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
}
