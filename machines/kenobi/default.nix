{
  inputs,
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
    ./ingress
    ./dns
    ./networks
    ./services
  ];

  os = {
    hostName = builtins.baseNameOf ./.;
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
    useDHCP = false;
  };

  services = {
    resolved = {
      dnssec = "false";
    };

    fail2ban = {
      enable = true;
    };
  };

  security = {
    acme = {
      acceptTerms = true;
      defaults = {
        email = "accounts+letsencrypt-kenobi-defaul-stg@romaindeville.fr";
        server = "https://acme-staging-v02.api.letsencrypt.org/directory";
      };
    };
  };
}
