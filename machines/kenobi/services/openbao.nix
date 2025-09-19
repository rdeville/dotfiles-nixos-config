{
  inputs,
  lib,
  ...
}: let
  nginx = {
    listen = [
      {
        addr = "127.0.0.1";
        port = 8000;
      }
    ];
  };
in {
  services = {
    nginx = {
      enable = true;
      virtualHosts = {
        "vault.romaindeville.xyz" = let
          aiAgent = builtins.attrNames (
            builtins.fromJSON (
              builtins.readFile (inputs.ai-robot-txt + "/robots.json")
            )
          );
          antiAiHeader = ''
            add_header X-Robots-Tag: "noai; ${
              lib.strings.concatStringsSep ";" (builtins.map (agent: "${agent}: none") aiAgent)
            }";
          '';
        in {
          inherit (nginx) listen;
          extraConfig = ''
            ${builtins.readFile (inputs.ai-robot-txt + "/nginx-block-ai-bots.conf")}

            ${antiAiHeader}
          '';
          locations = {
            "/" = {
              root = "/var/lib/acme/acme-challenge";
            };
          };
        };
      };
    };
  };

  security = {
    acme = {
      certs = {
        "vault.romaindeville.xyz" = {
          email = "accounts+letsencrypt-openbao-kenobi@romaindeville.fr";
          webroot = "/var/lib/acme/acme-challenge";
          group = "openbao";
          server = "https://acme-v02.api.letsencrypt.org/directory";
        };
      };
    };
  };

  os = {
    flavors = {
      openbao = {
        enable = true;
        clusterAddr = "http://127.0.0.1:8201";
        apiAddr = "http://127.0.0.1:8200";
        listeners = [
          {
            tlsCertFile = "/var/lib/acme/vault.romaindeville.xyz/cert.pem";
            tlsKeyFile = "/var/lib/acme/vault.romaindeville.xyz/key.pem";
            customResponseHeaders = {
              extraDefault = let
                aiAgent = builtins.attrNames (
                  builtins.fromJSON (
                    builtins.readFile (inputs.ai-robot-txt + "/robots.json")
                  )
                );
              in {
                Content-Security-Policy = [
                  "connect-src https://vault.romaindeville.xyz"
                ];
                X-Robots-Tag =
                  [
                    "noai"
                  ]
                  ++ (builtins.map (agent: "${agent}: none") aiAgent);
              };
            };
          }
        ];
        storage = {
          type = "raft";
          raft = {
            node_id = "kenobi";
          };
        };
      };
    };
  };

  topology = {
    self = {
      services = {
        openbao = {
          name = "OpenBao";
          info = "vault.romaindeville.xyz";
          icon = ../../../assets/images/services/openbao.png;
        };
      };
    };
  };
}
