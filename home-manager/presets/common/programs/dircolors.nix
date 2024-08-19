{...}: {
  programs = {
    dircolors = {
      enable = true;
      extraConfig = builtins.readFile (
        builtins.fetchurl {
          url = "https://raw.githubusercontent.com/trapd00r/LS_COLORS/master/LS_COLORS";
          sha256 = "0frxj9l5x1a4w5l80vr48sdjc0hzzq0sh16pb8v0dya1i6k6mgq7";
        }
      );
    };
  };
}
