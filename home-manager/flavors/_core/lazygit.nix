{
  config,
  lib,
  ...
}: let
  name = builtins.baseNameOf ./.;
  subname = "lazygit";
  cfg = config.hm.flavors.${name}.${subname};

  clr = config.colors.material.hex;
in {
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

  config = lib.mkIf cfg.enable {
    programs = {
      zsh = {
        zsh-abbr = {
          abbreviations = {
            lz = "lazygit";
          };
        };
      };

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
  };
}
