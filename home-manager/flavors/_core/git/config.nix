{
  config,
  lib,
  ...
}: let
  name = builtins.baseNameOf ../.;
  subname = "git";
  cfg = config.hm.flavors.${name}.${subname};

  clr = config.colors.material.hex;

  green = clr.green_500;
  light_green = clr.light_green_500;
  lime = clr.lime_500;
  yellow = clr.yellow_500;
  amber = clr.amber_500;
  orange = clr.orange_500;
  deep_orange = clr.deep_orange_500;
  red = clr.red_500;
  purple = clr.purple_500;
  deep_purple = clr.deep_purple_500;
  cyan = clr.cyan_500;
  light_blue = clr.light_blue_500;
  indigo = clr.indigo_500;
in {

  config = lib.mkIf cfg.enable {
    programs = {
      git = {
        extraConfig = {
          # GIT-* COMMAND CONFIG
          # ==============================================================================
          # Core
          # https://git-scm.com/docs/git
          core = {
            autocrlf = "input";
            editor = "nvim";
            commentChar = "#";
            whitespace = "fix,blank-at-eol,blank-at-eof,space-before-tab,trailing-space,cr-at-eol,-indent-with-non-tab";
          };

          # https://git-scm.com/docs/git-blame
          blame = {
            coloring = "highlightRecent";
            showEmail = true;
          };

          # https://git-scm.com/docs/git-checkout
          checkout = {
            defaultRemote = "origin";
          };

          # https://git-scm.com/docs/gitcredentials
          credential = {
            helper = "cache --timeout 432000";
          };

          # https://git-scm.com/docs/git-diff
          diff = {
            submodule = "diff";
            tool = "nvimdiff";
            colorMoved = true;
            colorMovedWS = "no";
          };

          # https://git-scm.com/docs/git-difftool
          difftool = {
            prompt = false;
          };

          # https://git-scm.com/docs/git-fetch
          fetch = {
            recurseSubmodules = "on-demand";
            prune = true;
            pruneTags = true;
            parallel = 0;
          };

          # https://git-scm.com/docs/git-grep
          grep = {
            lineNumber = true;
            column = true;
            extendedRegexp = true;
            threads = 2;
            fallbackToNoIndex = true;
          };

          # https://git-scm.com/docs/git-help
          help = {
            browser = "firefox";
          };

          # https://www.git-scm.com/docs/git-init
          init = {
            defaultBranch = "main";
          };

          # https://git-scm.com/docs/git-merge
          merge = {
            tool = "nvim -d";
          };

          # https://git-scm.com/docs/git-mergetool
          mergetool = {
            prompt = true;
          };

          # https://git-scm.com/docs/git-push
          push = {
            autoSetupRemote = true;
            default = "current";
            followTags = true;
          };

          # https://git-scm.com/docs/git-rebase
          rebase = {
            stat = true;
            autoStash = true;
          };

          # https://git-scm.com/docs/git-remote
          remote = {
            pushDefault = "origin";
          };

          # https://git-scm.com/docs/git-status
          status = {
            relativePaths = true;
            branch = true;
            showStash = true;
            showUntrackedFiles = "all";
            submoduleSummary = true;
          };

          # https://git-scm.com/docs/git-stash
          stash = {
            showPatch = true;
          };

          # https://git-scm.com/docs/git-submodule
          submodule = {
            recurse = true;
            fetchJobs = 2;
          };

          # CONFIG UNDEPENDANT TO GIT-* COMMAND
          # ==============================================================================
          # COLOR CONFIGURATION
          color = {
            blame = {
              highlightRecent = builtins.concatStringsSep "," [
                "${green}"
                "12 month ago, ${light_green}"
                "9 month ago, ${lime}"
                "6 month ago, ${yellow}"
                "3 month ago, ${amber}"
                "1 month ago, ${orange}"
                "2 week ago, ${deep_orange}"
                "1 week ago, ${red}"
              ];
              repeatedLines = "${cyan}";
            };

            branch = {
              current = "${cyan}";
              local = "${green}";
              remote = "${yellow}";
              upstream = "${red}";
            };

            decorate = {
              branch = "${green}";
              remoteBranch = "${yellow}";
              tag = "${purple} bold";
              stash = "${deep_purple} bold";
              HEAD = "${light_blue}";
            };

            grep = {
              context = "dim";
              filename = "${deep_purple}";
              function = "${yellow}";
              lineNumber = "${light_green}";
              column = "${indigo}";
              match = "${red}";
              selected = "normal";
              separator = "dim";
            };

            interactive = {
              prompt = "${light_green} bold";
              header = "${yellow}";
              hint = "${cyan} dim";
              error = "${red} bold";
            };

            push = {
              error = "${red} bold";
            };

            remote = {
              hint = "${cyan} dim";
              success = "${green}";
              warning = "${yellow}";
              error = "${red}";
            };

            status = {
              header = "${cyan} dim";
              added = "${light_green} bold";
              changed = "${yellow} bold";
              untracked = "${red} bold";
              nobranch = "${red}";
              branch = "${cyan}";
              localBranch = "${green}";
              remoteBranch = "${yellow}";
              unmerged = "${red}";
            };

            transport = {
              rejected = "${red}";
            };
          };

          # COLUMN CONFIGURATION
          column = {
            ui = "auto column nodense";
            status = "plain";
          };

          # PRETTY CONFIG
          pretty = {
            customfuller = builtins.concatStringsSep "" [
              "%C(${yellow})commit %H %Creset%C(${purple} bold)%d%Creset%n"
              "%C(dim)Author:%Creset\t%C(${green})%an <%ae>%Creset %C(${red})%G?%n"
              "%C(dim)Date:%Creset  \t%C(${light_blue} dim)%cr%Creset%n"
              "%C(dim)Title:%Creset \t%s%n"
              "%+b%Creset"
            ];
            customoneline = builtins.concatStringsSep "" [
              "%C(${yellow})%h%Creset%Creset "
              "%Creset%C(${light_blue} dim)%cr%Creset\t"
              "%Creset%C(${green})[%an]%Creset\t"
              "%Creset%s%C(${purple} bold)%d"
            ];
            customgraph = builtins.concatStringsSep "" [
              "\t%C(${yellow})%h%Creset%Creset "
              "%Creset%C(${light_blue} dim)%cr%Creset\t"
              "%Creset%C(${green})[%an]%Creset\t"
              "%Creset%s%C(${purple} bold)%d"
            ];
          };
        };
      };
    };
  };
}
