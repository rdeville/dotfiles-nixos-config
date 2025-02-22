{
  config,
  lib,
  pkgs,
  ...
}: let
  name = builtins.baseNameOf ./.;
  cfg = config.hm.flavors.${name};
in {
  options = {
    hm = {
      flavors = {
        ${name} = {
          enable = lib.mkEnableOption "Install ${name} Home-Manager flavor.";
        };
      };
    };
  };

  config = lib.mkIf cfg.enable {
    home = {
      packages = with pkgs; [
        texliveFull
      ];
    };

    programs = {
      zsh = {
        initExtra = ''
          mktex() {
            if [[ $# -eq 1 ]] && ! [[ $1 == 'bib' ]]; then
              if [[ $1 == 'clean' ]]; then
                rm -f ./*.{aux,bbl,blg,log,out,idx,ilg,ind,toc,d}
              elif [[ $1 == 'veryclean' ]]; then
                rm -f ./*.{aux,bbl,blg,log,out,idx,ilg,ind,toc,d,pdf}
              else
                local pdflatex_cmd="xelatex -file-line-error -halt-on-error $1"
                "''${pdflatex_cmd}" && bibtex ./*.aux && "''${pdflatex_cmd}" 2>/dev/null
              fi
            else
              grep -lFm 1 'begin{document}' -- *.tex | while read -r f; do
                local pdflatex_cmd="xelatex -file-line-error -halt-on-error '$f'"
                if [[ $# -eq 1 ]] && [[ $1 == 'bib' ]]; then
                  "''${pdflatex_cmd}" && bibtex ./*.aux && "''${pdflatex_cmd}" 2>/dev/null
                else
                  "''${pdflatex_cmd}" && "''${pdflatex_cmd}" 2>/dev/null
                fi
              done
            fi
          }
        '';
      };
    };
  };
}
