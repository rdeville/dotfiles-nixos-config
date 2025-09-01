{
  modulesPath,
  config,
  pkgs,
  lib,
  ...
}: let
  nixpkgs = {
    config = {
      allowUnfreePredicate = pkg:
        builtins.elem (lib.getName pkg) [
          "zsh-abbr"
        ];
    };
  };
  users = {
    nixos = {
      isSudo = true;
      password = "nixos";
      openssh = {
        authorizedKeys = {
          keyFiles = [
            ../darth-maul/users/rdeville/_keys/rdeville-darth-maul.pub
            ../rey/users/rdeville/_keys/rdeville-rey.pub
          ];
        };
      };
    };
    root = {
      password = "root";
    };
  };
in {
  imports = [
    (modulesPath + "/installer/cd-dvd/installation-cd-minimal.nix")
  ];

  facter = {
    reportPath = ../${config.os.hostName}/facter.json;
  };

  documentation = {
    nixos = {
      includeAllModules = lib.mkForce false;
    };
  };

  boot = {
    loader = {
      grub = {
        enable = lib.mkForce false;
      };
    };
  };

  networking = {
    useDHCP = lib.mkForce true;
  };

  isoImage = {
    squashfsCompression = "gzip -Xcompression-level 1";
  };

  # Enable SSH in the boot process.
  systemd = {
    services = {
      sshd = {
        wantedBy = pkgs.lib.mkForce ["multi-user.target"];
      };
    };
  };

  os = {
    hostName = "nixos-live";
    system = "x86_64-linux";

    users = {
      defaultUserShell = pkgs.bash;
      inherit users;
    };

    flavors = {
      ssh-server = {
        enable = true;
        openFirewall = true;
      };
    };
  };

  home-manager = {
    users = {
      nixos = {
        inherit nixpkgs;
        imports = [
          ../_templates/_users/nixos/server.nix
        ];
      };
      root = {
        inherit nixpkgs;
        hm = {
          username = "root";
        };
      };
    };
  };
}
