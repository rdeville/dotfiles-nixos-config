{
  config,
  lib,
  ...
}: let
  name = "kubernetes";
  cfg = mkLib.mkGetSarshipModuleConfig name;
  mkLib = import ../lib.nix {inherit config;};

  sep = mkLib.sep.${cfg.position};
  fg = mkLib.colors.grey_100;
  bg = mkLib.colors.blue_700;
in {
  options = mkLib.mkSetStarshipModuleOptions name {
    disabled = lib.mkEnableOption "Disable starship ${name} module.";

    position = lib.mkOption {
      type = lib.types.str;
      description = "Position of the module (right or left)";
      default = "left";
    };

    contexts = lib.mkOption {
      description = "Customized styles and symbols for specific contexts.";
      default = [];
      type = lib.types.listOf (lib.types.submodule {
        options = {
          context_pattern = lib.mkOption {
            type = lib.types.str;
            description = "Required Regular expression to match current Kubernetes context name.";
          };

          user_pattern = lib.mkOption {
            type = lib.types.str;
            description = "Regular expression to match current Kubernetes user name.";
            default = "";
          };

          context_alias = lib.mkOption {
            type = lib.types.str;
            description = "Context alias to display instead of the full context name.";
            default = "";
          };

          user_alias = lib.mkOption {
            type = lib.types.str;
            description = "User alias to display instead of the full user name.";
            default = "";
          };

          style = lib.mkOption {
            type = lib.types.str;
            description = "The style for the module when using this context. If not set, will use module's style.";
            default = "";
          };

          symbol = lib.mkOption {
            type = lib.types.str;
            description = "The symbol for the module when using this context. If not set, will use module's symbol.";
            default = "";
          };
        };
      });
    };
  };

  config = {
    programs = {
      starship = {
        settings = {
          ${name} = {
            inherit
              (cfg)
              disabled
              contexts
              ;
            # A format string representing the symbol displayed before the Cluster.
            symbol = "󱃾 ";
            # Which extensions should trigger this module.
            detect_extensions = [];
            # Which filenames should trigger this module.
            detect_files = [];
            # Which folders should trigger this modules.
            detect_folders = [];
            # Which environmental variables should trigger this module
            detect_env_vars = ["KUBECONFIG"];
            # The style used for the module
            style = "bg:${bg} fg:${fg}";
            #The format for the module.
            format = lib.concatStrings [
              (sep bg)
              "[ $symbol$user@$cluster $context:$namespace ]($style)"
            ];
          };
        };
      };
    };
  };
}
