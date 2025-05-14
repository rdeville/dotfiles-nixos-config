{
  config,
  lib,
  ...
}: let
  users = {
    rdeville = {
      isSudo = true;
      extraGroups = [
        "ydotool"
      ];
      openssh = {
        authorizedKeys = {
          keyFiles = [
            ../darth-maul/rdeville/_keys/rdeville-darth-maul.pub
            ../rey/rdeville/_keys/rdeville-rey.pub
          ];
        };
      };
    };
    azathoth = {};
    cthulhu = {};
    root = {};
  };

  secrets = builtins.foldl' (acc: elem:
    {
      "users/${elem}/password" = {
        neededForUsers = true;
      };
    }
    // acc) {} (
    builtins.filter (user:
      ! (
        # Ignore users azathoth and cthulhu, no password login
        builtins.match "(test|azathoth|cthulhu)" user != []
      )) (builtins.attrNames users)
  );
in {
  boot = {
    tmp = {
      # Clean /tmp on boot
      cleanOnBoot = true;
    };

    loader = {
      systemd-boot = {
        enable = false;
      };

      efi = {
        canTouchEfiVariables = true;
      };

      grub = {
        enable = true;
        device = "nodev";
        useOSProber = true;
        efiSupport = true;
        # efiInstallAsRemovable = true;
      };
    };
  };

  facter = {
    reportPath = ../${config.os.hostName}/facter.json;
  };

  documentation = {
    nixos = {
      includeAllModules = lib.mkForce false;
    };
  };

  sops = {
    inherit secrets;
    age = {
      keyFile = "/etc/ssh/.age.key";
    };
    defaultSopsFile = ../${config.os.hostName}/secrets.enc.yaml;
  };

  programs = {
    dconf = {
      enable = true;
    };
  };

  os = {
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
