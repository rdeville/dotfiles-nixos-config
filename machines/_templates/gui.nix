{...}: {
  hardware = {
    graphics = {
      enable = true;
    };
  };

  programs = {
    ydotool = {
      enable = true;
      group = "ydotool";
    };
  };

  os = {
    isGui = true;

    flavors = {
      audio = {
        enable = true;
      };

      display-manager = {
        enable = true;
      };

      window-manager = {
        enable = true;
      };
    };
  };
}
