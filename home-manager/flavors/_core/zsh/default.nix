{
  config,
  lib,
  ...
}: let
  name = builtins.baseNameOf ../.;
  subname = "zsh";
  cfg = config.hm.flavors.${name}.${subname};
in {
  imports = [
    ./history.nix
    ./plugins.nix
  ];

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

  config = {
    programs = {
      zsh = {
        inherit (cfg) enable;

        dotDir = "${config.xdg.cacheHome}/zsh";
        defaultKeymap = "viins";
        profileExtra = ''
          export LC_ALL="en_US.UTF-8"
        '';

        initContent = lib.mkBefore ''
          ABBR_GET_AVAILABLE_ABBREVIATION=1
          ABBR_LOG_AVAILABLE_ABBREVIATION=1

          ${(builtins.readFile ./_completion.zsh)}
          ${(builtins.readFile ./_zshrc.zsh)}
        '';

        shellGlobalAliases = {
          YQ = "| yq .";
          JQ = "| jq .";
          G = "| grep ";
          C = "cat ";
        };

        shellAliases = {
          # append indicator at the end, show dir first, always show icons and
          # show human readable
          ls = lib.mkForce "lsd -F --group-dirs first --icon always -h";
          sl = "ls";
          l = "ls";
          ll = lib.mkForce "ls -l"; # Otherwise conflict with lsd aliases
          la = lib.mkForce "ls -a"; # Otherwise conflict with lsd aliases
          lla = lib.mkForce "ls -al"; # Otherwise conflict with lsd aliases
          # Utility
          tree = lib.mkForce "ls --tree"; # Otherwise conflict with lsd aliases
          lt = lib.mkForce "tree"; # Otherwise conflict with lsd aliases
          # grep overload
          grep = "grep --color=auto";
          # cd overload
          "cd.." = "cd ../";
          ".." = "cd ..";
          "..." = "cd ../../";
          "...." = "cd ../../../";
          "~" = "cd ~";
          # dir and file manipulation (cp, mv, scp) to be interactive and verbose
          mkdir = "mkdir -p";
          md = "mkdir -p";
          mv = "mv -iv";
          cp = "cp -iv";
          scp = "scp -iv";
          rm = "rm -iv";
          # sudo overload and utility
          "_" = "sudo";
          # clear all cache files and system
          ccache = "sudo sh -c \"sync; echo 3 > /proc/sys/vm/drop_caches\"";
          # rsync useful options
          rsync = "rsync -avz --progress -h";
        };

        zsh-abbr = {
          abbreviations = {
            c = "clear";

            # Follow redirects
            cl = "curl -L";
            # Follow redirects, download as original name
            clo = "curl -L -O";
            # Follow redirects, download as original name, continue
            cloc = "curl -L -C - -O";
            # Follow redirects, download as original name, continue, retry 5 times
            clocr = "curl -L -C - -O --retry 5";
            # Follow redirects, fetch banner
            clb = "curl -L -I";
            # See only response headers from a get request
            clhead = "curl -D - -so /dev/null";

            # Some sops abbr
            sd = "sops decrypt";
            sdi = "sops decrypt --in-place";
            se = "sops encrypt";
            sei = "sops encrypt --in-place";
          };
        };
      };
    };
  };
}
