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
          enable = lib.mkEnableOption "Install k3s Related Packages";

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
      firewall = lib.mkIf (cfg.role != "local") {
        allowedTCPPorts = [
          6443 # k3s: required so that pods can reach the API server (running on port 6443 by default)
          # 2379 # k3s, etcd clients: required if using a "High Availability Embedded etcd" configuration
          # 2380 # k3s, etcd peers: required if using a "High Availability Embedded etcd" configuration
        ];
        allowedUDPPorts = [
          # 8472 # k3s, flannel: required if using multi-node for inter-node networking
        ];
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
