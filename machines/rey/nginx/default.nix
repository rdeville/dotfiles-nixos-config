{lib, ...}: let
  proxy = {
    "vault.local.tekunix.cloud" = "127.0.0.1:8200";
    "kube.local.tekunix.internal" = "192.168.20.3:6443";
    "argo.local.tekunix.cloud" = "192.168.20.4:443";
  };
in {
  networking = {
    hosts = {
      "127.0.0.1" = builtins.attrNames proxy;
    };
  };

  services = {
    nginx = {
      enable = true;
      streamConfig = ''
        map $ssl_preread_server_name $targetBackend {
          ${lib.strings.concatStringsSep "\n" (builtins.map (
          addr: "${addr} ${proxy.${addr}};"
        ) (builtins.attrNames proxy))}
          }

        server {
          listen 0.0.0.0:443;

          proxy_connect_timeout 1s;
          proxy_timeout 3s;

          proxy_pass $targetBackend;
          ssl_preread on;
        }
      '';

      virtualHosts = let
        listen = [
          {
            addr = "127.0.0.1";
            port = 80;
          }
        ];
      in {
        "localhost" = {
          inherit listen;
          locations = {
            "/" = {
              root = "/var/lib/www";
            };
          };
        };
      };
    };
  };
}
