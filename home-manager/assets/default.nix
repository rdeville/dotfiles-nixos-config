{...}: {
  xdg = {
    dataFile = {
      "bin" = {
        enable = true;
        recursive = true;
        source = ./scripts;
      };
    };
  };
}
