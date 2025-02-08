{...}: let
  base = import ./base.nix;

  users = {
    romaindeville = {
      isSudo = true;
      password = "romaindeville";
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
    };
  };
}
