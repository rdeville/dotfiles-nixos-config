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

  prod = mkLib.colors.red_500;
  stg = mkLib.colors.yellow_500;

  mkContextParam = context: param:
    if context.${param} != null
    then {"${param}" = context.${param};}
    else {};

  mkContext = contexts:
    builtins.foldl' (acc: elem: let
      context =
        (mkContextParam elem "context_pattern")
        // (mkContextParam elem "context_alias")
        // (mkContextParam elem "user_pattern")
        // (mkContextParam elem "user_alias")
        // (mkContextParam elem "symbol")
        // (mkContextParam elem "style")
        ;
    in [context] ++ acc) []
    contexts;
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
      type = lib.types.listOf (lib.types.submodule {
        options = {
          context_pattern = lib.mkOption {
            type = lib.types.nullOr lib.types.str;
            description = "Required Regular expression to match current Kubernetes context name.";
            default = null;
          };

          user_pattern = lib.mkOption {
            type = lib.types.nullOr lib.types.str;
            description = "Regular expression to match current Kubernetes user name.";
            default = null;
          };

          context_alias = lib.mkOption {
            type = lib.types.nullOr lib.types.str;
            description = "Context alias to display instead of the full context name.";
            default = null;
          };

          user_alias = lib.mkOption {
            type = lib.types.nullOr lib.types.str;
            description = "User alias to display instead of the full user name.";
            default = null;
          };

          style = lib.mkOption {
            type = lib.types.nullOr lib.types.str;
            description = "The style for the module when using this context. If not set, will use module's style.";
            default = null;
          };

          symbol = lib.mkOption {
            type = lib.types.nullOr lib.types.str;
            description = "The symbol for the module when using this context. If not set, will use module's symbol.";
            default = null;
          };
        };
      });
      default = [
        {
          context_pattern = ".*(prod).*";
          symbol = "󱃾 🚨";
          style = "bold fg:${prod} bg:${bg}";
        }
        {
          context_pattern = ".*(preprod|staging|stg).*";
          symbol = "󱃾 ⚠️";
          style = "bold fg:${stg} bg:${bg}";
        }
        {
          context_pattern = ".*(dev).*";
          symbol = "󱃾 ✅";
          style = "fg:${fg} bg:${bg}";
        }
        {
          context_pattern = ".*(local|lab).*";
          symbol = "󱃾 🧪";
          style = "fg:${fg} bg:${bg}";
        }
      ];
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
              ;
            contexts = mkContext cfg.contexts;
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
              "[ $symbol$user@$context:$namespace ]($style)"
            ];
          };
        };
      };
    };
  };
}
