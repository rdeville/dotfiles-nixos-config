{
  config,
  lib,
  ...
}: let
  name = builtins.baseNameOf ../.;
  subname = "git";
  cfg = config.hm.flavors.${name}.${subname};
in {
  imports = [
    ./alias.nix
    ./config.nix
    ./zsh.nix
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

            signing = {
              format = lib.mkOption {
                type = lib.types.str;
                description = "Format to use to Sign commit";
                default = "openpgp";
              };
            };

            profiles = lib.mkOption {
              type = lib.types.attrsOf lib.types.attrs;
              default = {};
              description = "Configuration to include for git.";
            };
          };
        };
      };
    };
  };

  config = lib.mkIf cfg.enable {
    programs = {
      git = {
        enable = true;

        includes =
          builtins.map (profile: let
            val = cfg.profiles."${profile}";
          in {
            inherit (val) condition;
            inherit (val) contents;
            contentSuffix = "${profile}.gitconfig";
          })
          (builtins.attrNames cfg.profiles);

        signing = {
          inherit (cfg.signing) format;
        };
      };

      delta = {
        # DETLA CONFIG (Git Pager config when using git diff)
        enable = true;
        enableGitIntegration = true;
        options = {
          dark = true;
          line-numbers = true;
          side-by-side = true;
          true-color = "always";
          plus-style = "syntax #013400";
          minus-style = "syntax #340001";
        };
      };

      difftastic = {
        # DETLA CONFIG (Git Pager config when using git diff)
        enable = ! config.programs.delta.enable;
        options = {
          background = "dark";
          display = "side-by-side-show-both";
        };
      };
    };
  };
}
