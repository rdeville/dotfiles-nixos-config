{
  config,
  lib,
  ...
}: let
  cfg = config.k8s-server;
in {
  options = {
    k8s-server = lib.mkOption {
      type = lib.types.submodule (import ./options.nix);
      description = ''
        Kubernetes server configuration, mainly network oriented
      '';
      default = {};
    };
  };

  imports = [
    ./options.nix
    ./networks.nix
  ];

  config = lib.mkIf cfg.enable {
    sops = {
      secrets = {
        "k8s-${cfg.env}-token" = {
          sopsFile = ../../../common/secrets/k8s-${cfg.env}.enc.yaml;
        };
      };
    };
    os = {
      flavors = {
        ssh-server = {
          enable = true;
        };
        network = {
          nftables = {
            extraForwardRules = ''
              iifname { cilium_host*, cilium_net* } oifname { cilium_host*, cilium_net* } accept comment "Allow bidirection for k3s"
            '';
          };
        };

        k3s = {
          inherit
            (cfg)
            role
            disableAgent
            clusterInit
            ;
          enable = true;
          serverAddr = cfg.clusterAddress;
          extraFlags =
            [
              "--node-ip 172.30.${cfg.envID}.${toString cfg.id}"
              "--node-external-ip 172.30.${cfg.envID}.${toString cfg.id}"
            ]
            ++ (
              if cfg.clusterInit
              then
                [
                  "--tls-san 172.30.${cfg.envID}.${toString cfg.id}"
                ]
                ++ (
                  if cfg.clusterDomain != []
                  then builtins.map (domain: "--tls-san ${domain}") cfg.clusterDomain
                  else []
                )
              else []
            );
          tokenFile = config.sops.secrets."k8s-${cfg.env}-token".path;
        };
      };
    };

    security = {
      sudo = {
        extraRules = [
          {
            users = [
              "cthulhu"
            ];
            commands = [
              {
                command = "ALL";
                options = ["SETENV" "NOPASSWD"];
              }
            ];
          }
        ];
      };
    };

    topology = {
      self = {
        services = {
          openssh = {
            hidden = false;
            info = lib.mkForce "";
          };
        };
      };
    };
  };
}
