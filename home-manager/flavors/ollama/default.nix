{
  config,
  lib,
  ...
}: let
  name = builtins.baseNameOf ./.;
  cfg = config.hm.flavors.${name};
in {
  options = {
    hm = {
      flavors = {
        ${name} = {
          enable = lib.mkEnableOption "Install ${name} Home-Manager flavor.";
          gpu = lib.mkOption {
            type = lib.types.enum [
              "none"
              "nvidia"
              "amd"
            ];
            description = ''
              What interface to use for hardware acceleration, see
              Home-Manager for more details.
            '';
            default = "none";
          };
          modelsLocation = lib.mkOption {
            type = lib.types.str;
            description = ''
              Path where the ollama models should be stored.
            '';
            default = "${config.xdg.cacheHome}/ollama/models";
          };
          environmentVariable = lib.mkOption {
            type = lib.types.attrsOf lib.types.str;
            description = ''
              Set arbitrary environment variables for the ollama service.
              Be aware that these are only seen by the ollama server not normal
              invocations like ollama run.
            '';
            default = {};
          };
          contextLength = lib.mkOption {
            type = lib.types.int;
            description = ''
              Context length to use unless otherwise specified.
            '';
            default = 4096;
          };
          keepAlive = lib.mkOption {
            type = lib.types.int;
            description = ''
              The duration, in minutes, that models stay loaded in memory.
            '';
            default = 5;
          };
          loadTimeout = lib.mkOption {
            type = lib.types.int;
            description = ''
              The duration, in minutes, that models stay loaded in memory.
            '';
            default = 5;
          };
        };
      };
    };
  };

  config = {
    services = {
      ollama = {
        inherit
          (cfg)
          enable
          ;
        acceleration =
          if cfg.gpu == "amd"
          then "rocm"
          else if cfg.gpu == "nvidia"
          then "cuda"
          else false;
        environmentVariables =
          {
            OLLAMA_MODELS = cfg.modelsLocation;
            OLLAMA_CONTEXT_LENGTH = toString cfg.contextLength;
            OLLAMA_KEEP_ALIVE = "${toString cfg.keepAlive}m";
            OLLAMA_LOAD_TIMEOUT = "${toString cfg.loadTimeout}m";
          };
      };
    };
  };
}
