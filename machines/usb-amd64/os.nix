{...}: let
  base = import ./base.nix;
  osBase = import ../base.nix;

  users = {
    nixos = {
      isSudo = true;
      password = "nixos";
      inherit (osBase.users) openssh;
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
          enable = true;
        };
      };

      window-manager = {
        enable = base.isGui;
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
    };
  };
}
