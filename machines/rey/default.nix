{
  inputs,
  config,
  lib,
  pkgs,
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
    ./nginx
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

  systemd = {
    network = {
      wait-online = {
        # Don't know why, but Rey now failed on this service
        # Moreover, rey can totally be offline
        enable = false;
      };
    };
  };

  environment = {
    etc = {
      "openbao/openbao.crt" = {
        source = ./nginx/ssl/openbao.crt;
      };
      "openbao/openbao.key" = {
        source = ./nginx/ssl/openbao.key;
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
            tlsCertFile = config.environment.etc."openbao/openbao.crt".source;
            tlsKeyFile = config.environment.etc."openbao/openbao.crt".source;
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
