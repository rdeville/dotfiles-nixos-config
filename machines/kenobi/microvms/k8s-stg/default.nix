{
  inputs,
  config,
  lib,
  ...
}: let
  isProd = config.os.isProd;
  parentName = config.os.hostName;
  vmName = "vm-${parentName}-${builtins.baseNameOf ./.}";
  imports =
    if isProd
    then [
      inputs.nixos-stable.nixosModules.os
    ]
    else [
      inputs.nixos.nixosModules.os
    ];
in {
  imports = [
    ./host
  ];

  microvm = {
    vms = {
      ${vmName} = {
        specialArgs = {
          inherit inputs lib;
        };

        config = {config, ...}: {
          imports =
            [
              inputs.sops-nix.nixosModules.sops
              inputs.nix-topology.nixosModules.default
              ./configuration.nix
              ./topology.nix
              ./networks
            ]
            ++ imports;

          os = {
            inherit isProd parentName;
            hostName = vmName;
          };
        };
      };
    };
  };

  services = {
    nginx = {
      enable = true;
      streamConfig = ''
        log_format basic '$remote_addr - - [$time_local] $protocol $status $bytes_sent $bytes_received $session_time "$upstream_addr"';

        access_log /var/log/nginx/kube.stg.tekunix.cloud.access.log basic;
        error_log /var/log/nginx/kube.stg.tekunix.cloud.error.log debug;

        upstream k8s-stg-http {
          server 172.30.144.201:80;
        }

        upstream k8s-stg-https {
          server 172.30.144.201:443;
        }

        server {
          listen 172.30.144.1:80;
          server_name *.stg.tekunix.cloud;
          proxy_pass k8s-stg-http;
        }

        server {
          listen 172.30.144.1:443;
          server_name *.stg.tekunix.cloud;
          proxy_pass k8s-stg-https;
        }
      '';

      virtualHosts = {
        "*.stg.tekunix.cloud" = {
          listen = [
            {
              addr = "89.234.140.170";
              port = 80;
            }
            {
              addr = "89.234.140.170";
              port = 443;
            }
          ];
          locations = {
            "/" = {
              proxyPass = "http://172.30.144.201";
              proxyWebsockets = true;
            };
          };
        };
      };
    };
  };
}
