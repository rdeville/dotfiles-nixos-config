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
              default = {};
            };
          };
          rootless = {
            enable =
              lib.mkDependEnabledOption ''
                Install ${name} with rootless support.
              ''
              cfg.enable;
            daemon = {
              settings = lib.mkOption {
                type = lib.types.attrs;
                description = "Configuration for docker daemon.";
                default = {};
              };
            };
          };
        };
      };
    };
  };

  config = lib.mkIf (cfg.enable || cfg.rootless.enable) {
    environment = {
      systemPackages = with pkgs; [
        docker
      ];
    };

    virtualisation = {
      docker = let
        settings = {
          fixed-cidr = "172.42.0.0/24";
          ipv6 = false;
        };
      in {
        inherit (cfg) enable;

        daemon = {
          settings = settings // cfg.daemon.settings;
        };

        autoPrune = {
          enable = true;
        };

        rootless = {
          inherit (cfg.rootless) enable;
          setSocketVariable = true;

          daemon = {
            settings =
              {
                fixed-cidr = "172.42.100.0/24";
                ipv6 = false;
              }
              // cfg.rootless.daemon.settings;
          };
        };
      };
    };
  };
}
