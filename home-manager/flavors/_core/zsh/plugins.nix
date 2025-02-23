{pkgs, ...}: {
  config = {
    programs = {
      zsh = {
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

        plugins = [
          # Kept for now as example
          # {
          #   file = "you-should-use.plugin.zsh";
          #   name = "you-should-use";
          #   src = pkgs.fetchFromGitHub {
          #     owner = "MichaelAquilina";
          #     repo = "zsh-you-should-use";
          #     rev = "master";
          #     sha256 = "XbTZpyUIpALsVezqnIfz7sV26hMi8z+2dW0mL2QbVIE=";
          #   };
          # }
        ];

        zsh-abbr = {
          enable = true;
        };
      };
    };
  };
}
