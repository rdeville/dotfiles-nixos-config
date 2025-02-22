{pkgs, ...}: {
  config = {
    home = {
      packages = with pkgs; [
          direnv # Automated development tools
      ];
    };

    programs = {
      zsh = {
        initExtra = ''
          source <(direnv hook zsh)
        '';

        zsh-abbr = {
          abbreviations = {
            da = "direnv allow";
            dr = "direnv reload";
            ds = "direnv status";
          };
        };
      };
    };
  };
}
