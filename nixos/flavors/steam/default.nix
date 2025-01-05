{
  config,
  lib,
  ...
}: let
  name = builtins.baseNameOf ./.;
  cfg = config.os.flavors.${name};
in {
  options = {
    os = {
      flavors = {
        ${name} = {
          enable = lib.mkEnableOption "Install steam Related Packages";
        };
      };
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
          openFirewall = false;
        };
        localNetworkGameTransfers = {
          # Open ports in the firewall for Steam Local Network Game Transfers
          openFirewall = false;
        };
      };
    };
  };
}
