{...}: {
  programs = {
    dircolors = {
      enable = true;
      extraConfig = builtins.readFile (
        builtins.fetchurl {
          url = "https://raw.githubusercontent.com/trapd00r/LS_COLORS/master/LS_COLORS";
          sha256 = "6d48ff10173a0d9fd41f87629bdebc046828f0a627fb3e37e8ecf837d1de37a9";
        }
      );
    };
  };
}
