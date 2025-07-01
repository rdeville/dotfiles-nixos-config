{lib, ...}: {
  imports = [
    ./hardware-configuration.nix
    ./topology.nix
    # Templated config
    ../_templates/server.nix
    ../_templates/gui.nix
    ../_templates/nvidia.nix
    ../_templates/main.nix
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

  networking = {
    interfaces = {
      enp0s25 = {
        useDHCP = true;
        ipv4 = {
          routes = [
            {
              address = "172.16.0.0";
              prefixLength = 16;
              via = "192.168.1.1";
            }
          ];
        };
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

  os = {
    hostName = builtins.baseNameOf ./.;

    flavors = {
      steam = {
        enable = true;
      };
    };
  };
}
