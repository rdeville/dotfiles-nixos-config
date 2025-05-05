{config, lib, ...}: {
  config = {
    programs = {
      zsh = {
        initContent = lib.mkBefore ''
          gpat() {
            git push --all
            git push --tags
            if git config --get remote.upstream.url | grep -q 'rdeville.public'; then
              git push upstream --all
              git push upstream --tags
            fi
          }

          gco() {
            local curr_branch
            local stash_msg
            local stash_idx

            curr_branch=$(git rev-parse --abbrev-ref HEAD)
            stash_msg="Autostash branch ''${curr_branch} before checkout"

            git stash push -m "''${stash_msg}"
            git checkout "$@"

            curr_branch=$(git rev-parse --abbrev-ref HEAD)
            stash_msg="Autostash branch ''${curr_branch} before checkout"
            if git stash list | grep -q "''${stash_msg}"; then
              echo "Unstash previous autostash"
              stash_idx="$(git stash list | grep "''${stash_msg}" | sed "s/.*@{\(.*\)}:.*''${curr_branch/\//\\/}.*''${stash_msg/\//\\/}/\1/")"
              git stash pop "''${stash_idx}"
            fi
          }

          gcb() {
            gco -b "$@"
          }
        '';

        shellAliases = {
          gtls =
            if config.hm.isDarwin
            then "git tag -l | gsort -V"
            else "git tag -l | sort -V";
          gf = "git fetch --all --prune";
          gft = "git fetch --all --prune --tags";
          gfv = "git fetch --all --prune --verbose";
          gftv = "git fetch --all --prune --tags --verbose";
          gclean = "git clean -fd";
          gll = "git log --graph --pretty=oneline --abbrev-commit";
          gg = "git log --graph --pretty=format:\"%C(bold)%h%Creset%C(magenta)%d%Creset %s %C(yellow)<%an> %C(cyan)(%cr)%Creset\" --abbrev-commit --date=relative";
          ggs = "gg --stat";
          gnew = "git log HEAD@{1}..HEAD@{0}";
        };

        zsh-abbr = {
          abbreviations = {
            g = "git";
            gcl = "git clone";
            ga = "git add";
            gap = "git add -p";
            gai = "git add --interactive";
            grm = "git rm";
            gmv = "git mv";
            gs = "git status";
            gss = "git status -s";
            gpl = "git pull";
            gup = "git fetch && git rebase";
            gp = "git push";
            gpf = "git push --force-with-lease";
            gr = "git remote -v";
            gra = "git remote add";
            gd = "git diff";
            gdt = "git difftool";
            gds = "git diff --staged";
            gc = "git commit -v";
            gca = "git commit -v --amend";
            gt = "git tag";
            gst = "git stash";
            gstb = "git stash branch";
            gstd = "git stash drop";
            gstl = "git stash list";
            gls = "git ls-files . --exclude-standard";
          };
        };
      };
    };
  };
}
