{config, ...}: let
  colors = import ../../../colors;
in {
  programs = {
    lazygit = {
      enable = true;
      settings = {
        gui = {
          mouseEvent = false;
          theme = {
            activeBorderColor = [
              colors.material-all.green_700
            ];
            inactiveBorderColor = [
              colors.material-all.grey_700
            ];
            searchingActiveBorderColor = [
              colors.material-all.cyan_800
              "bold"
            ];
            optionsTextColor = [
              colors.material-all.blue_500
              "bold"
            ];
            selectedLineBgColor = [
              colors.material-all.grey_800
            ];
            inactiveViewSelectedLineBgColor = [
              colors.material-all.black
            ];
            cherryPickedCommitFgColor = [
              colors.material-all.blue_500
            ];
            cherryPickedCommitBgColor = [
              colors.material-all.cyan_500
            ];
            # Foreground color of marked base commit (for rebase)
            markedBaseCommitFgColor = [
              colors.material-all.yellow_500
            ];
            unstagedChangesColor = [
              colors.material-all.red_500
            ];
            defaultFgColor = [
              colors.material-all.white
            ];
            nerdFontsVersion = "3";
            showDivergenceFromBaseBranch = "arrowAndNumber";
            border = "single";
            filterMode = "fuzzy";
            pager =
              if config.programs.git.delta.enable
              then "delta"
              else "";
            promptToReturnFromSubprocess = true;
          };
        };
      };
    };
  };
}
