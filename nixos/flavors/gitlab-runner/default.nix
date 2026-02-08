{
  config,
  lib,
  ...
}: let
  name = builtins.baseNameOf ./.;
  cfg = config.os.flavors.${name};
  service = {
    name = "gitlab-runner";
  };
  runners = builtins.attrNames cfg.runners;
in {
  imports = [
    ./options.nix
  ];
  config = lib.mkIf cfg.enable {
    virtualisation = {
      docker = {
        enable = true;
        autoPrune = {
          enable = true;
        };
      };
    };

    users = {
      users = {
        ${service.name} = {
          isSystemUser = true;
          group = service.name;
        };
      };
      groups = {
        ${service.name} = {};
      };
    };

    services = {
      gitlab-runner = {
        enable = true;
        settings = {
          inherit (cfg) concurrent;
          log_level = "warn";
          log_format = "json";
          check_interval = 5;
          shutdown_timeout = 0;
          session_server = {
            session_timeout = 1800;
          };
        };

        services = builtins.foldl' (acc: elem: let
          runner = cfg.runners.${elem};
        in
          {
            "${elem}" = {
              inherit
                (runner)
                authenticationTokenConfigFile
                description
                limit
                ;
              dockerImage = "alpine:latest";
              dockerPullPolicy = "if-not-present";
              executor = "docker";
              environmentVariables = {
                LC_ALL = "en_US.UTF-8";
              };
              requestConcurrency = 4;
            };
          }
          // acc) {}
        runners;
      };
    };
  };
}
