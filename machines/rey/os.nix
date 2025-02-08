{...}: let
  base = import ./base.nix;
  osBase = import ../base.nix;

  users = {
    rdeville = {
      isSudo = true;
      inherit (osBase.users) openssh;
      extraGroups = [
        "ydotool"
      ];
    };
    root = {
      inherit (osBase.users) openssh;
    };
  };

  sshKeyPaths = [
    "/etc/ssh/ssh_host_ed25519_key"
  ];

  secrets = builtins.foldl' (acc: user:
    {
      "users/${user}/password" = {
        neededForUsers = true;
      };
    }
    // acc) {} (builtins.filter (user: user != "test") (builtins.attrNames users));
in {
  sops = {
    inherit secrets;
    age = {
      inherit sshKeyPaths;
    };
    defaultSopsFile = ./secrets.enc.yaml;
  };

  os = {
    inherit (base) hostName system;

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
