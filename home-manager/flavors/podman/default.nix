{
  config,
  pkgs,
  lib,
  ...
}: let
  name = builtins.baseNameOf ./.;
  cfg = config.hm.flavors.${name};
in {
  options = {
    hm = {
      flavors = {
        ${name} = {
          enable = lib.mkEnableOption "Install container Related Packages";

          containers = lib.mkOption {
            type = lib.types.attrs;
            description = ''
              Object describing containers to run with podman
              See https://github.com/nix-community/home-manager/blob/master/modules/services/podman-linux/containers.nix
            '';
            default = {};
          };

          networks = lib.mkOption {
            type = lib.types.attrs;
            description = ''
              Object describing networks to run with podman
              See https://github.com/nix-community/home-manager/blob/master/modules/services/podman-linux/networks.nix
            '';
            default = {};
          };
        };
      };
    };
  };

  config = lib.mkIf cfg.enable {
    home = {
      packages = with pkgs; [
        buildah
      ];
    };

    services = {
      podman = {
        enable = true;
        autoUpdate = {
          enable = true;
          onCalendar = "Sun *-*-* 00:00";
        };
        containers = cfg.containers;
        networks = cfg.networks;
        settings = {
          containers = {};
          policy = {};
          registries = {
            block = [];
            insecure = [];
            search = [
              "docker.io"
            ];
          };
          storage = {};
        };
      };
    };
  };
}
