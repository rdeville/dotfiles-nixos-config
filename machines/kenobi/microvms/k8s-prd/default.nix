{
  self,
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
          inherit inputs lib self;
        };

        config = {config, ...}: {
          imports =
            [
              inputs.sops-nix.nixosModules.sops
              inputs.nix-topology.nixosModules.default
              ./configuration.nix
              ./topology.nix
              ./networks.nix
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
      virtualHosts = {
        "*.tekunix.cloud" = {
          listen = [
            {
              addr = "";
              port = 80;
            }
            {
              addr = "";
              port = 443;
            }
          ];
          locations = {
            "/" = {
              proxyPass = "http://172.30.128.201";
              proxyWebsockets = true;
            };
          };

          extraConfig = ''
            log_format basic '$remote_addr - - [$time_local] $protocol $status $bytes_sent $bytes_received $session_time "$upstream_addr"';

            access_log /var/log/nginx/kube.tekunix.cloud.access.log basic;
            error_log /var/log/nginx/kube.tekunix.cloud.error.log debug;
          '';
        };
      };
    };
  };
}
