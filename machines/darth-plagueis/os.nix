{...}: let
  base = import ./base.nix;
in {
  os = {
    inherit (base) hostName system;

    users = {
      users = {
        rdeville = {
          isSudo = true;
        };
        root = {};
      };
    };

    flavors = {
      _core = {
        nix-ld = {
          enable = true;
        };
      };

      ssh-server = {
        enable = true;
      };
    };
  };
}
