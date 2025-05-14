{
  modulesPath,
  pkgs,
  ...
}: let
  users = {
    nixos = {
      isSudo = true;
      password = "nixos";
      openssh = {
        authorizedKeys = {
          keyFiles = [
            ../darth-maul/rdeville/_keys/rdeville-darth-maul.pub
            ../rey/rdeville/_keys/rdeville-rey.pub
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

  networking = {
    useDHCP = true;
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
      inherit users;
    };

    flavors = {
      ssh-server = {
        enable = true;
      };
    };
  };
}
