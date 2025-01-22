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
        nix-ld = {
          enable = true;
        };
      };
      display-manager = {
        enable = base.isGui;
        ly = {
          enable = base.isGui;
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
      window-manager = {
        enable = base.isGui;
        awesome = {
          enable = base.isGui;
        };
        hyprland = {
          enable = base.isGui;
        };
      };
      ssh-server = {
        enable = true;
      };
      steam = {
        enable = false;
      };
    };
  };
}
