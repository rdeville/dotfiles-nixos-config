{
  config,
  inputs,
  hostCfg,
  lib,
  pkgs,
  ...
}: let
  mkLib = import ../../../lib/default.nix {inherit inputs;};
  flavorCfg =
    if hostCfg.flavors ? audio
    then hostCfg.flavors.audio
    else {
      enable = false;
    };
in {
  imports =
    builtins.map (
      item: (import ./${item} {inherit inputs hostCfg flavorCfg config lib pkgs;})
    ) (builtins.filter (
      item:
        item != "default.nix"
    ) (mkLib.mkListFiles ./.));

  options = {
    audio = {
      enable = lib.mkEnableOption "Install Bluetooth Related Packages";
    };
  };

  config = lib.mkIf flavorCfg.enable {
    hardware = {
      pulseaudio = {
        enable = false;
      };
    };

    services = {
      # Sound
      pipewire = {
        enable = true;
        pulse.enable = true;
        jack.enable = true;
      };
    };
  };
}
