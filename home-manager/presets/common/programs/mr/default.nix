{lib, config, ...}: {
  programs = {
    mr = {
      enable = true;
    };
  };

  xdg = {
    configFile = {
      mr = {
        source = ./lib;
      };
    };
  };

  home = {
    file = {
      ".mrconfig" = lib.mkForce {
        text = ''
          [DEFAULT]
          lib =
            # Load method library
            DEBUG_LEVEL="''${DIRENV_DEBUG_LEVEL:-"INFO"}"
            for file in "''${HOME}/${config.xdg.configFile.mr.target}"/*
            do
              source "''${file}"
            done

          pull          = mr_update "$@"
          update        = mr_update "$@"
          push          = mr_push "$@"
          status        = mr_status "$@"
          remote        = mr_remote "$@"
          branch        = mr_branch "$@"
          glab          = glab "$@"
          git           = git "$@"

          # Teach mr how to `mr gc` in git repos.
          git_gc = git gc "$@"

          include =
            cat "''${XDG_DATA_DIR:-''${HOME}/.local/share}/mr/hosts/''${HOST}/''${USER}.git"

          # vim: ft=conf
          '';
      };
    };
  };
}
