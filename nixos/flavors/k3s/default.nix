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

          token = lib.mkOption {
            type = lib.types.str;
            default = "";
            description = ''
              Token string to join existing cluster.
              Only useful in multi-node setup
            '';
          };

          tokenFile = lib.mkOption {
            type = lib.types.nullOr lib.types.path;
            default = null;
            description = ''
              Path to file containing token to join existing cluster.
              Only useful in multi-node setup
            '';
          };

          extraFlags = lib.mkOption {
            type = lib.types.listOf lib.types.str;
            default = [];
            description = "List of string describing options to passe to k3s.";
            example = [
              "--disable metric-server"
            ];
          };

          clusterInit = lib.mkOption {
            type = lib.types.bool;
            default = false;
            description = "Set to true for the first node.";
          };

          serverAddr = lib.mkOption {
            type = lib.types.str;
            default = "";
            description = "Address of the first node.";
          };

          disableAgent = lib.mkOption {
            type = lib.types.bool;
            default = false;
            description = "Only run the control-plane, not the worker.";
          };

          labels = lib.mkOption {
            type = lib.types.listOf lib.types.str;
            default = [];
            description = "List of labels to add to the node.";
          };

          taints = lib.mkOption {
            type = lib.types.listOf lib.types.str;
            default = [];
            description = "List of taints to add to the node.";
          };
        };
      };
    };
  };

  config = lib.mkIf cfg.enable {
    services = {
      k3s = {
        enable = true;

        inherit
          (cfg)
          token
          tokenFile
          disableAgent
          serverAddr
          clusterInit
          ;

        role =
          if cfg.role == "local"
          then "server"
          else cfg.role;

        extraFlags =
          if cfg.role != "agent"
          then
            builtins.toString ([
                # Deactivate flannel related networking since I use Cilium
                "--flannel-backend none"
                "--disable-network-policy"
                # Deactivate kube-proxy since I replace it with Cilium
                "--disable-kube-proxy"
                # Deactivate metrics-server since I'll manage it myself
                "--disable=metrics-server"
                # Deactivate traefik since I use ingress-nginx
                "--disable=traefik"
                # Deactivate ServiceLB since I'll use Cilium
                "--disable=servicelb"
                # Deactivate CoreDNS integration since I'll manage it myself
                "--disable=coredns"
                # Deactivate Local Storage since I'll use rook-ceph
                "--disable=local-storage"
              ]
              ++ (builtins.map (label: "--node-label ${label}") cfg.labels)
              ++ (builtins.map (taint: "--node-taint ${taint}") cfg.taints)
              ++ cfg.extraFlags)
          else
            builtins.toString [
              cfg.extraFlags
            ];
      };
    };
  };
}
