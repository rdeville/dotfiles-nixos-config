{
  config,
  lib,
  ...
}: let
  name = builtins.baseNameOf ../.;
  subname = "git";
  cfg = config.hm.flavors.${name}.${subname};
in {
  config = lib.mkIf cfg.enable {
    programs = {
      git = {
        settings = {
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
            # Fetch from and merge with another repository or local branch
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
        };
      };
    };
  };
}
