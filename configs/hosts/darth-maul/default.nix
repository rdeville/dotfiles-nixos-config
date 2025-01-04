{...}: let
  sshKeyPaths = [
    "/etc/ssh/ssh_host_ed25519_key"
  ];
  users = {
    rdeville = {
      isSudo = true;
      openssh = {
        authorizedKeys = {
          keyFiles = [
            ../../pubkeys/rdeville-darth-maul.pub
          ];
        };
      };
    };
    root = {};
  };
  secrets =
    builtins.listToAttrs (builtins.map (user: {
      name = "users/${user}/password";
      value = {
        neededForUsers = true;
      };
    }) (builtins.filter (user: user != "test") (builtins.attrNames users)));
in {
  extraConfig = {
    sops = {
      inherit secrets;
      age = {
        inherit sshKeyPaths;
      };
      defaultSopsFile = ./darth-maul.enc.yaml;
    };
  };

  os = {
    hostName = "darth-maul";
    system = "x86_64-linux";
    isGui = true;
    isMain = true;

    users = {
      inherit users;
    };

    flavors = {
      _core = {
        nix-ld = {
          enable = true;
        };
      };
      display-manager = {
        enable = true;
        ly = {
          enable = true;
        };
      };
      window-manager = {
        enable = true;
        awesome = {
          enable = true;
        };
        hyprland = {
          enable = true;
        };
      };
      ssh-server = {
        enable = true;
      };
      steam = {
        enable = true;
      };
    };
  };
}
