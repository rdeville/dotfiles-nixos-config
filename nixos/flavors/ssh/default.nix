{
  inputs,
  hostCfg,
  config,
  lib,
  pkgs,
  ...
}: let
  mkLib = import ../../../lib/default.nix {inherit inputs;};
  flavorCfg = hostCfg.flavors.ssh;
in {
  # Define a user account. Don't forget to set a password with ‘passwd’.
  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  imports =
    builtins.map (
      item: (import ./${item} {inherit inputs hostCfg flavorCfg config lib pkgs;})
    ) (builtins.filter (
      item:
        item != "default.nix"
    ) (mkLib.mkListFiles ./.));
}
