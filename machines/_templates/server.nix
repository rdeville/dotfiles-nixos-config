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
        "deploy"
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
      extraGroups = [
        "deploy"
      ];
      openssh = {
        authorizedKeys = {
          keyFiles = [
            ../darth-maul/azathoth/_keys/azathoth-darth-maul.pub
            ../rey/azathoth/_keys/azathoth-rey.pub
            ../kenobi/azathoth/_keys/azathoth-kenobi.pub
          ];
        };
      };
    };
    cthulhu = {
      isSudo = true;
      openssh = {
        authorizedKeys = {
          keyFiles = [
            ../darth-maul/cthulhu/_keys/cthulhu-darth-maul.pub
            ../rey/cthulhu/_keys/cthulhu-rey.pub
            ../kenobi/cthulhu/_keys/cthulhu-kenobi.pub
          ];
        };
      };
    };
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

  security = {
    sudo = {
      extraRules = [
        {
          groups = [
            "deploy"
          ];
          runAs = "azathoth";
          commands = [
            {
              command = "/run/current-system/sw/bin/nix-store";
              options = ["SETENV" "NOPASSWD"];
            }
          ];
        }
        {
          users = [
            "cthulhu"
          ];
          commands = [
            {
              command = "ALL";
              options = ["SETENV" "NOPASSWD"];
            }
          ];
        }
      ];
    };
  };

  home-manager = {
    users = builtins.foldl' (acc: elem:
      {
        ${elem} = {
          imports =
            if elem == "rdeville"
            then
              if config.os.isMain
              then [
                ./_users/${elem}/server.nix
                ./_users/${elem}/gui.nix
                ./_users/${elem}/main.nix
              ]
              else if config.os.isGui
              then [
                ./_users/${elem}/server.nix
                ./_users/${elem}/gui.nix
              ]
              else [
                ./_users/${elem}/server.nix
              ]
            else [
              ./_users/${elem}/server.nix
            ];
        };
      }
      // acc) {} (builtins.attrNames users);
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
