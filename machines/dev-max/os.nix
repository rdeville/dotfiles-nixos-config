{...}: let
  base = import ./base.nix;

  users = {
    nixos = {
      isSudo = true;
      password = "nixos";
    };
    root = {
      password = "root";
    };
  };
in {
  os = {
    inherit (base) hostName system;
    users = {
      inherit users;
    };

    flavors = {
      _core = {
        enable = true;
        nix-ld = {
          enable = true;
        };
      };

      display-manager = {
        enable = true;
        gdm = {
          enable = false;
        };
        ly = {
          enable = true;
        };
      };

      docker = {
        enable = true;
      };

      k3s = {
        enable = true;
      };

      printing = {
        enable = true;
      };

      ssh-server = {
        enable = true;
      };

      steam = {
        enable = true;
      };

      window-manager = {
        enable = true;
        awesome = {
          enable = true;
        };
        hyprland = {
          enable = true;
        };
        plasma = {
          enable = true;
        };
      };
    };
  };
}
