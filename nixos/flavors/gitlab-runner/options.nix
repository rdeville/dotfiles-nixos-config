{
  config,
  lib,
  ...
}: let
  name = builtins.baseNameOf ./.;
  cfg = config.os.flavors.${name};
in {
  options = {
    os = {
      flavors = {
        ${name} = {
          enable = lib.mkEnableOption "Install ${name} NixOS flavors.";
          concurrent = lib.mkOption {
            type = lib.types.int;
            description = ''
              Limits how many jobs can run concurrently across all registered
              runners.
            '';
            default = 4;
          };
          runners = lib.mkOption {
            default = {};
            description = ''
              Attributes with runner information
            '';
            type = lib.types.attrsOf (lib.types.submodule {
              options = {
                description = lib.mkOption {
                  type = lib.types.nullOr lib.types.str;
                  description = ''
                    Description of the runner
                  '';
                };

                limit = lib.mkOption {
                  type = lib.types.int;
                  description = ''
                    Limits how many jobs can runner car run.
                  '';
                  default = cfg.concurrent;
                };

                authenticationTokenConfigFile = lib.mkOption {
                  type = lib.types.path;
                  description = ''
                    Absolute path to a file with environment variables
                    used for gitlab-runner registration with *runner registration
                    tokens*.

                    A list of all supported environment variables can be found in
                    `gitlab-runner register --help`.

                    The ones you probably want to set are:
                    - `CI_SERVER_URL=<CI server URL>`
                    - `REGISTRATION_TOKEN=<registration secret>`
                  '';
                };
              };
            });
          };
        };
      };
    };
  };
}
