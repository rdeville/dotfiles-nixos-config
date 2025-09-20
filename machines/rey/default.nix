{
  inputs,
  config,
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
    ./nginx
  ];

  sops = {
    secrets = {
      "openbao/cert" = {
        format = "binary";
        sopsFile = ./nginx/ssl/openbao.crt.enc.asc;
        key = "";
        group = config.users.users.openbao.group;
        mode = "0640";
        reloadUnits = [
          "openbao.service"
        ];
      };
      "openbao/key" = {
        format = "binary";
        sopsFile = ./nginx/ssl/openbao.key.enc.asc;
        key = "";
        group = config.users.users.openbao.group;
        mode = "0640";
        reloadUnits = [
          "openbao.service"
        ];
      };
    };
  };

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
            tlsCertFile = config.sops.secrets."openbao/cert".path;
            tlsKeyFile = config.sops.secrets."openbao/key".path;
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
