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
          enable = lib.mkEnableOption "Install ${name} NixOS flavors.";

          role = lib.mkOption {
            type = lib.types.enum [
              "server"
              "agent"
              "local"
            ];
            default = "local";
            example = "server";
            description = "Set the role of the node";
          };
        };
      };
    };
  };

  config = lib.mkIf cfg.enable {
    networking = {
        # allowedTCPPorts = lib.mkIf (cfg.role != "local")  [
        #   # Kube API
        #   6443
        #   # 2379 # k3s, etcd clients: required if using a "High Availability Embedded etcd" configuration
        #   # 2380 # k3s, etcd peers: required if using a "High Availability Embedded etcd" configuration
        # ];
      };
    };

    services = {
      k3s = {
        enable = true;
        role =
          if cfg.role == "local"
          then "server"
          else cfg.role;
        extraFlags = toString [
          # "--debug" # Optionally add additional args to k3s
        ];
      };
    };
  };
}
