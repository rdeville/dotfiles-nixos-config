{
  config,
  lib,
  ...
}: let
  name = builtins.baseNameOf ./.;
  subname = "zsh";
  cfg = config.hm.flavors.${name}.${subname};
in {
  options = {
    hm = {
      flavors = {
        ${name} = {
          ${subname} = {
            enable =
              lib.mkDependEnabledOption ''
                Install ${name}.${subname} Home-Manager flavor.
              ''
              config.hm.flavors.${name}.enable;
          };
        };
      };
    };
  };

  config = lib.mkIf cfg.enable {
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
        profileExtra = ''
          ZPROFILE_CUSTOM="$HOME/.config/zsh/profile"
          if [[ -f "$ZPROFILE_CUSTOM" ]]; then
            source $ZPROFILE_CUSTOM
          else
            echo "ERROR: File $ZSHRC_CUSTOM does not exist"
          fi
        '';
        initExtra = ''
          ZSHRC_CUSTOM="$HOME/.config/zsh/zshrc"
          if [[ -f "$ZSHRC_CUSTOM" ]]; then
            source $ZSHRC_CUSTOM
          else
            echo "ERROR: File $ZSHRC_CUSTOM does not exist"
          fi
        '';
      };
    };
  };
}
