{...}: {
  xdg = {
    dataFile = {
      "bin" = {
        enable = true;
        recursive = true;
        source = ./scripts;
      };
    };
    configFile = {
      "tmuxp/nixos.yaml" = {
        enable = true;
        source = ./tmuxp/nixos.yaml;
      };
    };
  };
}
