{...}: {
  programs = {
    dircolors = {
      enable = true;
      extraConfig = builtins.readFile (
        builtins.fetchurl {
          url = "https://raw.githubusercontent.com/trapd00r/LS_COLORS/master/LS_COLORS";
          sha256 = "1w66v5fagh7slpvh56c1ncb8vqfcb2c8j9ymcd832hlqsgpa96s5";
        }
      );
    };
  };
}
