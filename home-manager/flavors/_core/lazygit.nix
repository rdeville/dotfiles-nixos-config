{
  config,
  lib,
  ...
}: let
  name = builtins.baseNameOf ./.;
  cfg = config.hm.flavors.${name};

  clr = config.colors.material.hex;
in
  lib.mkIf cfg.enable {
    programs = {
      lazygit = {
        enable = true;
        settings = {
          gui = {
            mouseEvent = false;
            theme = {
              activeBorderColor = [
                clr.green_700
              ];
              inactiveBorderColor = [
                clr.grey_700
              ];
              searchingActiveBorderColor = [
                clr.cyan_800
                "bold"
              ];
              optionsTextColor = [
                clr.blue_500
                "bold"
              ];
              selectedLineBgColor = [
                clr.grey_800
              ];
              inactiveViewSelectedLineBgColor = [
                clr.black
              ];
              cherryPickedCommitFgColor = [
                clr.blue_500
              ];
              cherryPickedCommitBgColor = [
                clr.cyan_500
              ];
              # Foreground color of marked base commit (for rebase)
              markedBaseCommitFgColor = [
                clr.yellow_500
              ];
              unstagedChangesColor = [
                clr.red_500
              ];
              defaultFgColor = [
                clr.white
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
