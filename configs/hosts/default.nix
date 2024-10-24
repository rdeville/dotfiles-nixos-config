{
  config,
  lib,
  ...
}: let
  cfg = config.hostCfg;
in {
  options = {
    hostCfg = {
      hostName = lib.mkOption {
        type = lib.types.string;
      };

      terminal = lib.mkOption {
        type = lib.types.string;
        default = "kitty";
      };

      editor = lib.mkOption {
        type = lib.types.string;
        default = "nvim";
      };

      presets = lib.mkOption {
        type = lib.types.attrs;
        default = {};
        example = {
          presetName = {
            enable = true;
          };
        };
        description = ''
          Attrset where key is the name of the preset and value is the config
          passed to the preset
        '';
      };
    };
  };

  config = {
    hostCfg = {
      terminal = cfg.terminal;
      editor = cfg.editor;
      presets =
        {
          minimal = {
            enable = true;
          };
        }
        // cfg.presets;
    };
  };
}
