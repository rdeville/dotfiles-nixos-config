{...}: {
  programs = {
    zsh = {
      enable = true;
      autocd = true;
      autosuggestion = {
        enable = true;
      };
      syntaxHighlighting = {
        enable = true;
        highlighters = [
          "main"
        ];
      };
      dotDir = ".cache/zsh";
      initExtra = ''
        ZSHRC_CUSTOM="$HOME/.config/zsh/zshrc"
        if [[ -f "$ZSHRC_CUSTOM" ]]; then
          source $ZSHRC_CUSTOM
        else
          echo "ERROR: File $ZSHRC_CUSTOM exists"
        fi
      '';
    };
  };
}
