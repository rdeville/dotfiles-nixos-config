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
    hostName = lib.mkForce (builtins.baseNameOf ./.);
    hosts = {
      "192.168.1.10" = ["kenobi" "kenobi.tekunix.internal"];
    };

    interfaces = {
      enp0s25 = {
        useDHCP = true;
        # ipv4 = {
        #   routes = [
        #     {
        #       address = "172.16.0.0";
        #       prefixLength = 16;
        #       via = "192.168.1.1";
        #     }
        #   ];
        # };
      };
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
