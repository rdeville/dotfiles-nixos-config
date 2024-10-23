{
  hostCfg,
  config,
  pkgs,
  lib,
  ...
}: let
  cfg =
    if hostCfg.flavors ? steam
    then config.steam // hostCfg.flavors.steam
    else {
      enable = false;
    };
in {
  options = {
    steam = {
      enable = lib.mkEnableOption "Install steam Related Packages";
    };
  };

  config = lib.mkIf cfg.enable {
    programs = {
      steam = {
        enable = true;
        remotePlay = {
          # Open ports in the firewall for Steam Remote Play
          openFirewall = true;
        };
        dedicatedServer = {
          # Open ports in the firewall for Source Dedicated Server
          openFirewall = true;
        };
        localNetworkGameTransfers = {
          # Open ports in the firewall for Steam Local Network Game Transfers
          openFirewall = true;
        };
      };
    };
  };
}
