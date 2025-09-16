{lib, ...}: {
  imports = [
    ./hardware-configuration.nix
    ./topology.nix
    # Templated config
    ../_templates/server.nix
    ../_templates/gui.nix
    ../_templates/nvidia.nix
    ../_templates/main.nix
    ./networks.nix
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

  os = {
    hostName = builtins.baseNameOf ./.;

    flavors = {
      steam.enable = true;
    };
  };
}
