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
    ./networks
    ./microvms
    ./topology.nix
  ];

  nixpkgs = {
    config = {
      allowUnfreePredicate = pkg:
        builtins.elem (lib.getName pkg) [
          "nvidia-x11"
          "nvidia-settings"
          "steam"
          "steam-unwrapped"
        ];
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

  networking = {
    hosts = {
      "127.0.0.1" = [
        "kube.rey.tekunix.cloud"
        "argocd.rey.tekunix.cloud"
      ];
    };
  };

  os = {
    hostName = builtins.baseNameOf ./.;

    flavors = {
      window-manager = {
        plasma.enable = false;
      };

      ssh-server = {
        openFirewall = true;
      };

      steam.enable = true;
    };
  };
}
