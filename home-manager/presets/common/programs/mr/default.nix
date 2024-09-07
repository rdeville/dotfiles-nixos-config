{
  lib,
  ...
}: {
  programs = {
    mr = {
      enable = true;
    };
  };

  xdg = {
    configFile = {
      mr = {
        source = ./lib;
      };
    };
  };

  home = {
    file = {
      ".mrconfig" = lib.mkForce {
        source = ./mrconfig;
      };
    };
  };
}
