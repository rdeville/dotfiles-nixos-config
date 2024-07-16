{
  userCfg,
  mkLib,
  pkgs,
  config,
  lib,
  ...
}: {
  programs = {
    git = {
      enable = true;
      includes =
        pkgs.lib.mkIf (userCfg ? git)
        (
          builtins.map (profile: let
            val = userCfg.git."${profile}";
          in {
            condition = val.condition;
            contents = val.contents;
            contentSuffix = "${profile}.gitconfig";
          })
          (builtins.attrNames userCfg.git)
        );
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
              "#4CAF50"
              "12 month ago, #8BC34A"
              "9 month ago, #CDDC39"
              "6 month ago, #FFEB3B"
              "3 month ago, #FFC107"
              "1 month ago, #FF9800"
              "2 week ago, #FF5722"
              "1 week ago, #F44336"
            ];
            repeatedLines = "#00BCD4";
          };

          branch = {
            current = "#00BCD4";
            local = "#4CAF50";
            remote = "#FFEB3B";
            upstream = "#F44336";
          };

          decorate = {
            branch = "#4CAF50";
            remoteBranch = "#FFEB3B";
            tag = "#9C27B0 bold";
            stash = "#673AB7 bold";
            HEAD = "#03A9F4";
          };

          grep = {
            context = "dim";
            filename = "#673AB7";
            function = "#FFEB3B";
            lineNumber = "#8BC34A";
            column = "#3F51B5";
            match = "#F44336";
            selected = "normal";
            separator = "dim";
          };

          interactive = {
            prompt = "#8BC34A bold";
            header = "#FFEB3B";
            hint = "#00BCD4 dim";
            error = "#F44336 bold";
          };

          push = {
            error = "#F44336 bold";
          };

          remote = {
            hint = "#00BCD4 dim";
            success = "#4CAF50";
            warning = "#FFEB3B";
            error = "#F44336";
          };

          status = {
            header = "#00BCD4 dim";
            added = "#8BC34A bold";
            changed = "#FFEB3B bold";
            untracked = "#F44336 bold";
            nobranch = "#F44336";
            branch = "#00BCD4";
            localBranch = "#4CAF50";
            remoteBranch = "#FFEB3B";
            unmerged = "#F44336";
          };

          transport = {
            rejected = "#F44336";
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
            "%C(#FFEB3B)commit %H %Creset%C(#9C27B0 bold)%d%Creset%n"
            "%C(dim)Author:%Creset\t%C(#4CAF50)%an <%ae>%Creset %C(#F44336)%G?%n"
            "%C(dim)Date:%Creset  \t%C(#03A9F4 dim)%cr%Creset%n"
            "%C(dim)Title:%Creset \t%s%n"
            "%+b%Creset"
          ];
          customoneline = builtins.concatStringsSep "" [
            "%C(#FFEB3B)%h%Creset%Creset "
            "%Creset%C(#03A9F4 dim)%cr%Creset\t"
            "%Creset%C(#4CAF50)[%an]%Creset\t"
            "%Creset%s%C(#9C27B0 bold)%d"
          ];
          customgraph = builtins.concatStringsSep "" [
            "\t%C(#FFEB3B)%h%Creset%Creset "
            "%Creset%C(#03A9F4 dim)%cr%Creset\t"
            "%Creset%C(#4CAF50)[%an]%Creset\t"
            "%Creset%s%C(#9C27B0 bold)%d"
          ];
        };
      };
      aliases = {
        # Apply patch to files and/or index
        ap = "apply";
        as = "apply --stat";
        ac = "apply --check";
        # Apply patches from a mailbox
        ama = "am --abort";
        amr = "am --resolved";
        ams = "am --skip";
        # list, create, or delete branches
        b = "branch";
        ba = "branch -a";
        bd = "branch -d";
        bdd = "branch -D";
        br = "branch -r";
        bc = "rev-parse --abbrev-ref HEAD";
        bu = "!git rev-parse --abbrev-ref --symbolic-full-name \"@{u}\"";
        # Record changes to repository
        c = "commit";
        ca = "commit --amend";
        ce = "commit --allow-empty";
        cea = "commit --allow-empty --amend";
        # Show changes between commits
        d = "diff";
        dp = "diff --patience";
        dc = "diff --cached";
        dk = "diff --check";
        dck = "diff --cached --check";
        dt = "difftool";
        dct = "difftool --cached";
        # Download objects and refs from another repository
        f = "fetch";
        fo = "fetch origin";
        fu = "fetch upstream";
        fm = "fetch main_upstream";
        # Prepare patches fro e-mail submission
        fp = "format-patch";
        # Verify connectivity and validity of objects in database
        fk = "fsck";
        # Print lines matching a pattern
        g = "grep";
        # Show commit logs
        l = "log --pretty=customfuller";
        l1 = "log --oneline --pretty=customoneline";
        lg = "log --graph --pretty=customgraph";
        # Information about files in index/working directory
        ls = "ls-files";
        lsf = "!git ls-files | grep -i";
        # Join two or more development histories together
        m = "merge";
        ma = "merge --abort";
        mc = "merge --continue";
        ms = "merge --skip";
        # Checkout branch or paths to working tree
        o = "checkout";
        om = "checkout master";
        ob = "checkout -b";
        # Prune all unreachable objects from the object database
        pr = "prune -v";
        # Update remote refs along with associated objects
        ps = "push";
        psf = "push -f";
        psu = "push -u";
        pst = "push --tags";
        # Push on origin
        pso = "push origin";
        psao = "push --all origin";
        psfo = "push -f origin";
        psuo = "push -u origin";
        # Push on master branch on origin remote
        psom = "push origin master";
        psaom = "push --all origin master";
        psfom = "push -f origin master";
        psuom = "push -u origin master";
        psoc = "!git push origin $(git bc)";
        psaoc = "!git push --all origin $(git bc)";
        psfoc = "!git push -f origin $(git bc)";
        psuoc = "!git push -u origin $(git bc)";
        psdc = "!git push origin :$(git bc)";
        # Fetch from and merge witrh another repository or local branch
        pl = "pull";
        pb = "pull --rebase";
        # Pull origin
        plo = "pull origin";
        pbo = "pull --rebase origin";
        plom = "pull origin master";
        ploc = "!git pull origin $(git bc)";
        pbom = "pull --rebase origin master";
        pboc = "!git pull --rebase origin $(git bc)";
        # Pull upstream
        plu = "pull upstream";
        plum = "pull upstream master";
        pluc = "!git pull upstream $(git bc)";
        pbum = "pull --rebase upstream master";
        pbuc = "!git pull --rebase upstream $(git bc)";
        # Forward-port local commits to the updated upstream head
        rb = "rebase";
        rba = "rebase --abort";
        rbc = "rebase --continue";
        rbi = "rebase --interactive";
        rbs = "rebase --skip";
        # Reset current HEAD to specified state
        re = "reset";
        rh = "reset HEAD";
        reh = "reset --hard";
        rem = "reset --mixed";
        res = "reset --soft";
        rehh = "reset --hard HEAD";
        remh = "reset --mixed HEAD";
        resh = "reset --soft HEAD";
        # Manage set of tracked repositories
        r = "remote";
        ra = "remote add";
        rr = "remote rm";
        rv = "remote -v";
        rn = "remote rename";
        rp = "remote prune";
        rs = "remote show";
        rao = "remote add origin";
        rau = "remote add upstream";
        rro = "remote remove origin";
        rru = "remote remove upstream";
        rso = "remote show origin";
        rsu = "remote show upstream";
        rpo = "remote prune origin";
        rpu = "remote prune upstream";
        # Remove files from the working tree and from the index
        rmf = "rm -f";
        rmrf = "rm -r -f";
        # Show working-tree status
        s = "status";
        sb = "status -s -b";
        # Stash away changes to dirty working directory
        sa = "stash apply";
        sc = "stash clear";
        sd = "stash drop";
        sl = "stash list";
        sp = "stash pop";
        ss = "stash save";
        ssk = "stash save -k";
        sw = "stash show";
        st = "!git stash list | wc -l 2>/dev/null | grep -oEi '[0-9][0-9]*'";
        # Create, list, delete or verify tag object signed with GPG
        t = "tag";
        td = "tag -d";
        # Show various types of objects
        w = "show";
        wp = "show -p";
        wr = "show -p --no-color";
        # Initialize, update or inspect submodules
        subup = "submodule update --init --recursive";
        subpull = "!git submodule foreach git pull --tags origin master";
        # git change-commits GIT_COMMITTER_NAME "old name" "new name"
        change-commits = "!f() { VAR1=$1; VAR='$'$1; OLD=$2; NEW=$3; echo \"Are you sure for replace $VAR $OLD => $NEW ?(Y/N)\";read OK;if [ \"$OK\" = 'Y' ] ; then shift 3; git filter-branch --env-filter \"if [ \\\"$\{VAR}\\\" = '$OLD' ]; then export $VAR1='$NEW';echo 'to $NEW'; fi\" $@; fi;}; f ";
      };
      delta = {
        # DETLA CONFIG (Git Pager config when using git diff)
        enable = true;
        options = {
          dark = true;
          line-numbers = true;
          side-by-side = true;
          true-color = "always";
          plus-style = "syntax #013400";
          minus-style = "syntax #340001";
        };
      };
    };
  };
}
