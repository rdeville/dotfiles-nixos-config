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

  secrets = builtins.listToAttrs (builtins.map (user: {
    name = "users/${user}/password";
    value = {
      neededForUsers = true;
    };
  }) (builtins.filter (user: user != "test") (builtins.attrNames users)));
in {
  sops = {
    inherit secrets;
    age = {
      inherit (osBase.sops) keyFile;
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

      audio = {
        enable = true;
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
          enable = false;
        };
        plasma = {
          enable = false;
        };
      };

      docker = {
        enable = true;
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
