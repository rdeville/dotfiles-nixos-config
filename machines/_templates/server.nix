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
    azathoth = {
      isSudo = true;
      # openssh = {
      #   authorizedKeys = {
      #     keyFiles = [
      #       ../darth-maul/azathoth/_keys/azathoth-darth-maul.pub
      #       ../rey/azathoth/_keys/azathoth-rey.pub
      #     ];
      #   };
      # };
    };
    cthulhu = {};
    root = {};
  };

  secrets =
    builtins.foldl' (acc: elem:
      {
        "users/${elem}/password" = {
          neededForUsers = true;
        };
      }
      // acc) {} (
      builtins.filter (user: (
        # Ignore users azathoth and cthulhu, no password login
        (builtins.match "test" user != [])
        && (builtins.match "azathoth" user != [])
        && (builtins.match "cthulhu" user != [])
      )) (builtins.attrNames users)
    )
    // {
      "keys/rsa" = {
        format = "binary";
        sopsFile = ../${config.os.hostName}/_keys/${config.os.hostName}-rsa.enc.asc;
        key = "";
      };
      "keys/ed25519" = {
        format = "binary";
        sopsFile = ../${config.os.hostName}/_keys/${config.os.hostName}-ed25519.enc.asc;
        key = "";
      };
    };
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

  environment = {
    etc = {
      "ssh/ssh_host_rsa_key" = {
        source = config.sops.secrets."keys/rsa".path;
      };
      "ssh/ssh_host_rsa_key.pub" = {
        source = ../${config.os.hostName}/_keys/${config.os.hostName}-rsa.pub;
      };
      "ssh/ssh_host_ed25519_key" = {
        source = config.sops.secrets."keys/ed25519".path;
      };
      "ssh/ssh_host_ed25519_key.pub" = {
        source = ../${config.os.hostName}/_keys/${config.os.hostName}-ed25519.pub;
      };
    };
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
