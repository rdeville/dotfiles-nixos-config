{
  inputs,
  pkgs,
  lib,
  ...
}: {
  imports = [
    # Templated config
    ../_templates/server.nix
    ../_templates/gui.nix
    ./topology.nix
    # Partition map
    inputs.disko.nixosModules.disko
    ./disko.nix
    # Other configurations
    # ./dns.nix
    ./_networks
  ];

  os = {
    hostName = builtins.baseNameOf ./.;
  };

  networking = {
    useDHCP = false;
  };

  environment = {
    systemPackages = with pkgs; [
      ethtool # manage NIC settings (offload, NIC feeatures, ...)
      tcpdump # view network traffic
      conntrack-tools # view network connection states
      traceroute # view network routes
      iw # view wlan interfaces and devices
    ];
  };

  services = {
    resolved = {
      dnssec = "allow-downgrade";
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
}
