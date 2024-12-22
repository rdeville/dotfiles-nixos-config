{...}: {
  programs = {
    dircolors = {
      enable = true;
      extraConfig = builtins.readFile (
        builtins.fetchurl {
          url = "https://raw.githubusercontent.com/trapd00r/LS_COLORS/master/LS_COLORS";
          sha256 = "1a4x93cmn4g4yzjvl5scah9pmzbqk1m71gfdnpbc6p2csg8yy8fi";
        }
      );
    };
  };
}
