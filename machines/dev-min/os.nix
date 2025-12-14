_: let
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
      };

      display-manager = {
        enable = false;
        gdm = {
          enable = false;
        };
        ly = {
          enable = false;
        };
      };

      docker = {
        enable = false;
      };

      k3s = {
        enable = false;
      };

      printing = {
        enable = false;
      };

      ssh-server = {
        enable = false;
      };

      steam = {
        enable = false;
      };

      window-manager = {
        enable = false;
        awesome = {
          enable = false;
        };
        hyprland = {
          enable = false;
        };
        plasma = {
          enable = false;
        };
      };
    };
  };
}
