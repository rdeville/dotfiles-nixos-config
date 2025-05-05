{pkgs, lib, ...}: {
  config = {
    home = {
      packages = with pkgs; [
        direnv # Automated development tools
      ];
    };

    programs = {
      zsh = {
        initContent = lib.mkBefore ''
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
