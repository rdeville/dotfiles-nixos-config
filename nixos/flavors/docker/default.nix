{
  config,
  pkgs,
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
          enable = lib.mkEnableOption "Install ${name} NixOS flavor.";
          daemon = {
            settings = lib.mkOption {
              type = lib.types.attrs;
              description = "Configuration for docker daemon.";
              default = {
                settings = {
                  fixed-cidr = "172.42.0.0/24";
                  ipv6 = false;
                };
              };
            };
          };
        };
      };
    };
  };

  config = lib.mkIf cfg.enable {
    environment = {
      systemPackages = with pkgs; [
        docker
      ];
    };

    virtualisation = {
      docker = {
        enable = true;
        daemon = {
          inherit (cfg.daemon) settings;
        };
        autoPrune = {
          enable = true;
        };
        rootless = {
          enable = true;
          daemon = {
            inherit (cfg.daemon) settings;
          };
        };
      };
    };
  };
}
