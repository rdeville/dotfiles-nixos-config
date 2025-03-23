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
        };
      };
    };
  };

  config = lib.mkIf cfg.enable {
    networking = {
      firewall = {
        enable = false;
        checkReversePath = "loose";
        allowedTCPPorts = [
          # HTTP(s)
          80
          443
          # Kube API
          6443
          # Required for Metrics Server using cilium
          10250
        ];
        allowedUDPPorts = [];
        # See: https://github.com/cilium/cilium/issues/27900#issuecomment-2572253315
        trustedInterfaces = [
          "cilium_net*"
          "cilium_host*"
          "cilium_vxlan"
          "lxc*"
        ];
      };
    };

    services = {
      k3s = {
        enable = true;

        inherit
          (cfg)
          token
          tokenFile
          ;

        role =
          if cfg.role == "local"
          then "server"
          else cfg.role;

        extraFlags = builtins.toString ([
            # Deactivate flannel related networking since I use Cilium
            "--flannel-backend none"
            "--disable-network-policy"
            # # Deactivate kube-proxy since I replace it with Cilium
            "--disable-kube-proxy"
            # Deactivate traefik since I use ingress-nginx
            "--disable=traefik"
            # Deactivate ServiceLB since I'll use MetalLB
            "--disable=servicelb"
            # Deactivate CoreDNS integration since I'll maintained deployment
            # with helm charts
            "--disable=coredns"
          ]
          ++ cfg.extraFlags);
      };
    };
  };
}
