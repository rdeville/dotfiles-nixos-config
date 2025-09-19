{
  inputs,
  lib,
  ...
}: {
  imports = [
    # Templated config
    ../_templates/server.nix
    ../_templates/main.nix
    ../_templates/gui.nix
    # Partition map
    inputs.disko.nixosModules.disko
    ./disko.nix
    ./networks.nix
    ./topology.nix
    # ./microvms
  ];

  programs = {
    ssh = {
      knownHosts = builtins.foldl' (acc: host:
        {
          "${host}-rsa" = {
            publicKeyFile = ../${host}/_keys/${host}-rsa.pub;
          };
          "${host}-ed25519" = {
            publicKeyFile = ../${host}/_keys/${host}-ed25519.pub;
          };
        }
        // acc) {}
      lib.getValidHosts;
    };
  };

  networking = {
    hosts = {
      "127.0.0.1" = [
        "vault.local.tekunix.cloud"
      ];
      "192.168.20.3" = [
        "kube.local.tekunix.internal"
      ];
      "192.168.20.4" = [
        "argo.local.tekunix.cloud"
      ];
    };
  };

  systemd = {
    network = {
      wait-online = {
        # Don't know why, but Rey now failed on this service
        # Moreover, rey can totally be offline
        enable = false;
      };
    };
  };
  services = {
    nginx = {
      enable = true;
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
        "vault.local.tekunix.cloud" = {
          inherit listen;
          locations = {
            "/" = {
              proxyPass = "http://127.0.0.1:8200";
            };
          };
        };
      };
    };
  };

  os = {
    hostName = builtins.baseNameOf ./.;

    flavors = {
      window-manager = {
        plasma.enable = false;
      };

      openbao = {
        enable = true;
        clusterAddr = "http://127.0.0.1:8201";
        apiAddr = "http://127.0.0.1:8200";
        listeners = [
          {
            tlsDisable = true;
          }
        ];
        storage = {
          type = "raft";
          raft = {
            node_id = "rey";
          };
        };
      };

      steam.enable = true;
    };
  };
}
